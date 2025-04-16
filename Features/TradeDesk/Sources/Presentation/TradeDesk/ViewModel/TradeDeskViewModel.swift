import Core
import Combine
import Foundation
import TradeDeskDomain
import NetworkManager

public class TradeDeskViewModel: BaseViewModel {
    private let usecase: TradeDeskUseCaseProtocol
    private let webSocketManager: WebSocketManager<AssetDomainModel>
    private var webSocketManagers: [WebSocketManager<AssetDomainModel>] = []
    private var cancellables = Set<AnyCancellable>()
    
    @Published public var isLoading: Bool = false
    @Published public var errorMessage: String? = nil
    @Published public var filteredAssets: [AssetDomainModel] = []
    
    @Published public var searchText: String = "" {
        didSet { filterAssets() }
    }
    
    @Published public var assets: [AssetDomainModel] = [] {
        didSet { filterAssets() }
    }
    
    
    public init(usecase: TradeDeskUseCaseProtocol) {
        self.usecase = usecase
        self.webSocketManager = WebSocketManager<AssetDomainModel>()
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
                    self.startListeningForAssets(assets: assets)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            })
            .store(in: &self.cancellables)
    }
    
    public func onDisappear() {
        self.webSocketManager.disconnect()
    }
    
    // Start listening for asset updates via WebSocket
    private func startListeningForAssets(assets: [AssetDomainModel]) {
        // Clear previous managers and connections
        self.webSocketManagers.forEach { $0.disconnect() }
        self.webSocketManagers.removeAll()

        // Split assets into chunks of 1024 (Binance's max stream limit per connection)
        let chunkedAssets = assets.chunked(into: 1024)

        for chunk in chunkedAssets {
            // Create combined stream URL
            let streams = chunk.map { "\($0.symbol.lowercased())@ticker" }.joined(separator: "/")
            let urlString = "wss://stream.binance.com:9443/stream?streams=\(streams)"

            guard let url = URL(string: urlString) else { continue }

            let manager = WebSocketManager<AssetDomainModel>()
            manager.connect(with: url)
            self.webSocketManagers.append(manager)

            // Subscribe to this manager's stream
            manager.dataPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] updatedAsset in
                    guard let self = self else { return }
                    if let index = self.assets.firstIndex(where: { $0.symbol == updatedAsset.symbol }) {
                        self.assets[index] = updatedAsset
//                        print("Updated \(updatedAsset.symbol) at index \(index)")
                    }
                }
                .store(in: &self.cancellables)
        }
    }
    
    private func filterAssets() {
        if searchText.isEmpty {
            filteredAssets = assets
        } else {
            filteredAssets = assets.filter { $0.symbol.lowercased().contains(searchText.lowercased()) }
        }
    }
}
