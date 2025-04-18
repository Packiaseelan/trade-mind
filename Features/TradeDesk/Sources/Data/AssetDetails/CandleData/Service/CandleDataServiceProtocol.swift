import Combine
import Core

public protocol CandleDataServiceProtocol {
    func fetchCandleData(symbol: String, interval: String, limit: String) -> AnyPublisher<CandleDataModel, NetworkError>
}
