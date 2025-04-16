import Core
import Combine

public final class MarketDataService: MarketDataServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    public func fetchTopAssets(limit: Int) -> AnyPublisher<[AssetDataModel], NetworkError> {
        let request = NetworkRequest(
            path: "ticker/24hr",
            method: .get,
            headers: ["Accept" : "*/*"]
        )
        return networkManager.request(with: request)
    }
}
