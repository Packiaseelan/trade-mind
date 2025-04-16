import Core
import Combine

public class MarketDataRepository: MarketDataRepositoryProtocol {
    private let service: MarketDataServiceProtocol
    
    private var cancellables = Set<AnyCancellable>() // To keep track of the subscription
    
    public init(service: MarketDataServiceProtocol) {
        self.service = service
    }
    
    public func fetchTopAssets(limit: Int) -> Future<Result<[AssetDataModel], NetworkError>, Never> {
        return Future { promise in
            self.service.fetchTopAssets(limit: limit)
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
