import Combine
import Core
import Shared
import TradeDeskData

public class TradeDeskUseCase: TradeDeskUseCaseProtocol {
    private let repository: MarketDataRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(repository: MarketDataRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchTopAssets(limit: Int) -> Future<Result<[AssetDomainModel], NetworkError>, Never> {
        return Future { promise in
            self.repository.fetchTopAssets(limit: limit)
                .map { stm in
                    stm.map { assets in
                        let mapper = self.getMapper()
                        return assets.map {
                            mapper.fromDataModelToDomainModel(data: $0) as! AssetDomainModel
                        }
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
        let mapper = DIContainer.container.resolve(BaseDomainMapper.self, name: TradeDeskModuleIdentifier.Mapper.marketData)!
        return mapper
    }
}
