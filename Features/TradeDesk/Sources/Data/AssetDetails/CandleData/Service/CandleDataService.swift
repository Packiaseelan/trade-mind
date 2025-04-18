import Core
import Combine

public final class CandleDataService: CandleDataServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    public func fetchCandleData(symbol: String, interval: String, limit: String) -> AnyPublisher<CandleDataModel, NetworkError> {
        let request = NetworkRequest(
            path: "klines?symbol=\(symbol)&interval=\(interval)&limit=\(limit)",
            method: .get,
            headers: ["Accept" : "*/*"]
        )
        return networkManager.request(with: request)
    }
}
