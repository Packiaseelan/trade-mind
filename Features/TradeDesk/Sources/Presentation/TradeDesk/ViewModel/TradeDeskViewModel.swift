import Core
import Combine
import Foundation
import TradeDeskDomain

public class TradeDeskViewModel: BaseViewModel {
    private let usecase: TradeDeskUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    @Published public var assets: [AssetDomainModel] = []
    
    public init(usecase: TradeDeskUseCaseProtocol) {
        self.usecase = usecase
    }
    
    public func onAppear() {
        self.isLoading = true
        self.usecase.fetchTopAssets(limit: 20 )
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let assets):
                    self.assets = assets
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            })
            .store(in: &self.cancellables)
    }
    
    public func onDisappear() { }
    
}
