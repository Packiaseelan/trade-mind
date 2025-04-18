import Core
import Combine

public protocol CandleDataRepositoryProtocol {
    func fetchCandleData(symbol: String, interval: String, limit: String) -> Future<Result<CandleDataModel, NetworkError>, Never>
}
