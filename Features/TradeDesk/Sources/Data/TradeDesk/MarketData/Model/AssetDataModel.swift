import Core

public struct AssetDataModel: BaseDataModel, Codable {
    public let symbol, priceChange, priceChangePercent, weightedAvgPrice: String
    public let prevClosePrice, lastPrice, lastQty, bidPrice: String
    public let bidQty, askPrice, askQty, openPrice: String
    public let highPrice, lowPrice, volume, quoteVolume: String
    public let openTime, closeTime, firstID, lastID: Int
    public let count: Int

    enum CodingKeys: String, CodingKey {
        case symbol, priceChange, priceChangePercent, weightedAvgPrice, prevClosePrice, lastPrice, lastQty, bidPrice, bidQty, askPrice, askQty, openPrice, highPrice, lowPrice, volume, quoteVolume, openTime, closeTime
        case firstID = "firstId"
        case lastID = "lastId"
        case count
    }
}
