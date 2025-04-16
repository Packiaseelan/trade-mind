import Combine
import Core

public protocol TradeDeskUseCaseProtocol {
    func fetchTopAssets(limit: Int) -> Future<Result<[AssetDomainModel], NetworkError>, Never>
}
