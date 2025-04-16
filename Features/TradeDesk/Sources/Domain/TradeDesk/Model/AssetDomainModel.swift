import Core
import Foundation

public struct AssetDomainModel: BaseDomainModel, Codable, Identifiable {
    public var id: String
    
    public let symbol, priceChange, priceChangePercent, weightedAvgPrice: String
    public let prevClosePrice, lastPrice, lastQty, bidPrice: String
    public let bidQty, askPrice, askQty, openPrice: String
    public let highPrice, lowPrice, volume, quoteVolume: String
    public let openTime, closeTime, firstID, lastID: Int
    public let count: Int

    enum CodingKeys: String, CodingKey {
        case id
        case symbol, priceChange, priceChangePercent, weightedAvgPrice, prevClosePrice, lastPrice, lastQty, bidPrice, bidQty, askPrice, askQty, openPrice, highPrice, lowPrice, volume, quoteVolume, openTime, closeTime
        case firstID = "firstId"
        case lastID = "lastId"
        case count
    }
    
    public init(symbol: String, priceChange: String, priceChangePercent: String, weightedAvgPrice: String, prevClosePrice: String, lastPrice: String, lastQty: String, bidPrice: String, bidQty: String, askPrice: String, askQty: String, openPrice: String, highPrice: String, lowPrice: String, volume: String, quoteVolume: String, openTime: Int, closeTime: Int, firstID: Int, lastID: Int, count: Int) {
        
        self.id = UUID().uuidString
        
        self.symbol = symbol
        self.priceChange = priceChange
        self.priceChangePercent = priceChangePercent
        self.weightedAvgPrice = weightedAvgPrice
        self.prevClosePrice = prevClosePrice
        self.lastPrice = lastPrice
        self.lastQty = lastQty
        self.bidPrice = bidPrice
        self.bidQty = bidQty
        self.askPrice = askPrice
        self.askQty = askQty
        self.openPrice = openPrice
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.volume = volume
        self.quoteVolume = quoteVolume
        self.openTime = openTime
        self.closeTime = closeTime
        self.firstID = firstID
        self.lastID = lastID
        self.count = count
    }
}
