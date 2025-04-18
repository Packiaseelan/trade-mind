import Core
import Shared
import Foundation

public class TradeDeskMapperModule: Module {
    public init() {}
    
    public func registerServices() {
        registerMarketDataMapperService()
        registerCandleDataMapperService()
    }
}

extension TradeDeskMapperModule {
    private func registerMarketDataMapperService() {
        DIContainer.container.register(
            BaseDomainMapper.self,
            name: TradeDeskModuleIdentifier.Mapper.marketData,
            factory: { _ in AssetDomainMapper() }
        )
    }
    
    private func registerCandleDataMapperService() {
        DIContainer.container.register(
            BaseDomainMapper.self,
            name: TradeDeskModuleIdentifier.Mapper.candleData,
            factory: { _ in CandleDomainMapper() }
        )
    }
}
