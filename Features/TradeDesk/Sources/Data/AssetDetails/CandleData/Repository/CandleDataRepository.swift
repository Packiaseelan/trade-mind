import Core
import Combine

public class CandleDataRepository: CandleDataRepositoryProtocol {
    private let service: CandleDataServiceProtocol
    
    private var cancellables = Set<AnyCancellable>() // To keep track of the subscription
    
    public init(service: CandleDataServiceProtocol) {
        self.service = service
    }
    
    public func fetchCandleData(symbol: String, interval: String, limit: String) -> Future<Result<CandleDataModel, NetworkError>, Never> {
        return Future { promise in
            self.service.fetchCandleData(symbol: symbol, interval: interval, limit: limit)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break // Do nothing, result handled in receiveValue
                    case .failure(let error):
                        promise(.success(.failure(error))) // Return failure result
                    }
                }, receiveValue: { assets in
                    promise(.success(.success(assets))) // Return success result with assets
                })
                .store(in: &self.cancellables)
        }
    }
}
