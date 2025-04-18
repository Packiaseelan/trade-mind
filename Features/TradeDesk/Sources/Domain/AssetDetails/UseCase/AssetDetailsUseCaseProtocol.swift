import Combine
import Core

public protocol AssetDetailsUseCaseProtocol {
    func fetchCandleData(symbol: String, interval: String, limit: String) -> Future<Result<CandleDomainModel, NetworkError>, Never>
}
