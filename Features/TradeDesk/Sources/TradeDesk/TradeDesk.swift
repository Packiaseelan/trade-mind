import Core
import Shared
import TradeDeskData
import TradeDeskDomain
import TradeDeskMapper
import TradeDeskPresentation

/// A class representing the Characters module within the application.
/// This class is responsible for registering services related to character functionalities,
/// particularly focusing on the student list feature. It conforms to the `Module` protocol,
/// which requires the implementation of the `registerServices` method.
public class TradeDeskModule: Module {
    
    /// Initializes a new instance of `CharactersModule`.
    /// This initializer sets up the module without any initial configuration.
    public init () {}
    
    /// Registers services for the Characters module.
    /// This method is responsible for setting up the necessary services and dependencies
    /// related to character functionalities, ensuring they are available for use throughout the application.
    public func registerServices() {
        TradeDeskMapperModule().registerServices()
        
        registerTradeDeskService()
        registerAssetDetailsService()
    }
}

extension TradeDeskModule {
    
    /// Registers the market data list service.
    /// This private method sets up the service responsible for managing the asset list,
    /// including its view model, use case, and repository.
    private func registerTradeDeskService() {
        DIContainer.container.register(TradeDeskViewModel.self) { resolver in
            let network = resolver.resolve(NetworkManagerProtocol.self, name: ModuleIdentifier.network)
            let service = MarketDataService(networkManager: network!)
            let repository = MarketDataRepository(service: service)
            let usecase = TradeDeskUseCase(repository: repository)
            
            return TradeDeskViewModel(usecase: usecase)
        }
    }
    
    /// Registers the asset details service.
    /// This private method sets up the service responsible for managing the asset details,
    /// including its view model, use case, and repository.
    private func registerAssetDetailsService() {
        DIContainer.container.register(AssetDetailsViewModel.self) { resolver in
            let network = resolver.resolve(NetworkManagerProtocol.self, name: ModuleIdentifier.network)
            let service = CandleDataService(networkManager: network!)
            let repository = CandleDataRepository(service: service)
            let usecase = AssetDetailsUseCase(repository: repository)
            
            return AssetDetailsViewModel(usecase: usecase)
        }
    }
}
