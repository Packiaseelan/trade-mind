import Core
import TradeDeskDomain
import TradeDeskData

public class AssetDomainMapper: BaseDomainMapper {
    public init() {}
    
    public func fromDataModelToDomainModel(data: any BaseDataModel) -> any BaseDomainModel {
        let dataModel = data as! AssetDataModel
        
        return AssetDomainModel(
            symbol: dataModel.symbol,
            priceChange: dataModel.priceChange,
            priceChangePercent: dataModel.priceChangePercent,
            weightedAvgPrice: dataModel.weightedAvgPrice,
            prevClosePrice: dataModel.prevClosePrice,
            lastPrice: dataModel.lastPrice,
            lastQty: dataModel.lastQty,
            bidPrice: dataModel.bidPrice,
            bidQty: dataModel.bidQty,
            askPrice: dataModel.askPrice,
            askQty: dataModel.askQty,
            openPrice: dataModel.openPrice,
            highPrice: dataModel.highPrice,
            lowPrice: dataModel.lowPrice,
            volume: dataModel.volume,
            quoteVolume: dataModel.quoteVolume,
            openTime: dataModel.openTime,
            closeTime: dataModel.closeTime,
            firstID: dataModel.firstID,
            lastID: dataModel.lastID,
            count: dataModel.count
        )
    }
}
