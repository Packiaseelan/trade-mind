import Core
import Combine
import Foundation
import TradeDeskDomain

public class AssetDetailsViewModel: BaseViewModel {
    private let usecase: AssetDetailsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    @Published public var prices: [CandleData] = []
    @Published public var smaPrices: [MovingAverageData] = []
    @Published public var selectedInterval: KlineInterval = .fiveMinutes {
        didSet { fetchCandleData() }
    }
    @Published var selectedChartType: ChartType = .candlestick
    
    public var asset: AssetDomainModel? = nil
    
    public init(usecase: AssetDetailsUseCaseProtocol) {
        self.usecase = usecase
    }
}

extension AssetDetailsViewModel {
    public func onInit(arguments: [String: Any]) {
        if let asset = arguments["asset"] {
            self.asset = asset as? AssetDomainModel
        }
    }
    
    public func onAppear() {
        fetchCandleData()
    }
    
    public func onDisappear() {}
    
    private func fetchCandleData() {
        guard let asset = self.asset else { return }
        self.isLoading = true
        let symbol = asset.symbol.uppercased()
        let interval = selectedInterval.rawValue
        let limit = "\(selectedInterval.limit)"
        self.usecase.fetchCandleData(symbol: symbol, interval: interval, limit: limit)
            .map { result in
                result.map { elements in
                    elements.compactMap { CandleData(from: $0) }
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let prices):
                    self.prices = prices
                    self.calculateSMA(period: 20)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            })
            .store(in: &self.cancellables)
    }
    
    private func calculateSMA(period: Int) {
        guard prices.count >= period else {
            self.smaPrices = []
            return
        }

        var sma: [MovingAverageData] = []
        for i in period..<prices.count {
            let slice = prices[i - period..<i]
            let average = slice.map { $0.close }.reduce(0, +) / Double(period)
            sma.append(MovingAverageData(time: prices[i].time, value: average))
        }
        self.smaPrices = sma
    }
}
