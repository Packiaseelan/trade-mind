import Combine
import Core
import Shared
import TradeDeskData

public class AssetDetailsUseCase: AssetDetailsUseCaseProtocol {
    private let repository: CandleDataRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(repository: CandleDataRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchCandleData(symbol: String, interval: String, limit: String) -> Future<Result<CandleDomainModel, NetworkError>, Never> {
        return Future { promise in
            self.repository.fetchCandleData(symbol: symbol, interval: interval, limit: limit)
                .map { stm in
                    stm.map { candle in
                        let mapper = self.getMapper()
                        return mapper.fromDataModelToDomainModel(data: candle) as! CandleDomainModel
                    }
                }
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break // No action needed on successful completion
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { studentModels in
                    promise(.success(studentModels))
                })
                .store(in: &self.cancellables)
        }
    }
    
    private func getMapper() -> BaseDomainMapper {
        let mapper = DIContainer.container.resolve(BaseDomainMapper.self, name: TradeDeskModuleIdentifier.Mapper.candleData)!
        return mapper
    }
}
