import Core
import Combine
import Foundation
import TradeDeskDomain
import NetworkManager

public class TradeDeskViewModel: BaseViewModel {
    private let usecase: TradeDeskUseCaseProtocol
    private var webSocketManagers: [WebSocketManager<AssetDomainModel>] = []
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    @Published public var assets: [AssetDomainModel] = []
    @Published public var filteredAssets: [AssetDomainModel] = []
    @Published public var searchText: String = ""
    
    public init(usecase: TradeDeskUseCaseProtocol) {
        self.usecase = usecase

        // Debounce search text and update filtered assets
        $searchText
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterAssets(with: text)
            }
            .store(in: &cancellables)
    }
    
    public func onAppear() {
        self.isLoading = true
        self.usecase.fetchTopAssets(limit: 3065)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let assets):
                    self.assets = assets
                    self.filteredAssets = assets
                    self.startListeningForAssets(assets: assets)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            })
            .store(in: &self.cancellables)
    }
    
    public func onDisappear() {
        self.webSocketManagers.forEach { $0.disconnect() }
        self.webSocketManagers.removeAll()
    }
    
    private func filterAssets(with text: String) {
        if text.isEmpty {
            filteredAssets = assets
        } else {
            filteredAssets = assets.filter { $0.symbol.lowercased().contains(text.lowercased()) }
        }
    }

    private func startListeningForAssets(assets: [AssetDomainModel]) {
        // Disconnect existing managers
        self.webSocketManagers.forEach { $0.disconnect() }
        self.webSocketManagers.removeAll()

        // Chunk assets for WebSocket stream (Binance supports 1024 max streams per connection)
        let chunkedAssets = assets.chunked(into: 1024)

        for chunk in chunkedAssets {
            let streams = chunk.map { "\($0.symbol.lowercased())@ticker" }.joined(separator: "/")
            let urlString = "wss://stream.binance.com:9443/stream?streams=\(streams)"

            guard let url = URL(string: urlString) else { continue }

            let manager = WebSocketManager<AssetDomainModel>()
            manager.connect(with: url)
            self.webSocketManagers.append(manager)

            manager.dataPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] updatedAsset in
                    guard let self = self else { return }
                    if let index = self.assets.firstIndex(where: { $0.symbol == updatedAsset.symbol }) {
                        self.assets[index] = updatedAsset
                        self.filterAssets(with: self.searchText)
                    }
                }
                .store(in: &self.cancellables)
        }
    }
}
