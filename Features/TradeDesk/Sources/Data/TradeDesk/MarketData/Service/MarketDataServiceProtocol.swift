import Combine
import Core

public protocol MarketDataServiceProtocol {
    func fetchTopAssets(limit: Int) -> AnyPublisher<[AssetDataModel], NetworkError>
}
