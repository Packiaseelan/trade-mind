import Core
import Combine

public protocol MarketDataRepositoryProtocol {
    func fetchTopAssets(limit: Int) -> Future<Result<[AssetDataModel], NetworkError>, Never>
}
