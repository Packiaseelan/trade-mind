import Core
import Foundation

public struct AssetDomainModel: BaseDomainModel, Codable, Identifiable, Hashable {
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

extension AssetDomainModel: WebSocketDecodable {
    public static func fromWebSocketString(_ string: String) -> AssetDomainModel? {
        guard let data = string.data(using: .utf8) else { return nil }

        struct CombinedStreamWrapper: Decodable {
            let stream: String
            let data: TickerDTO
        }

        struct TickerDTO: Decodable {
            let e: String
            let E: Int
            let s: String
            let p: String
            let P: String
            let w: String
            let x: String
            let c: String
            let Q: String
            let b: String
            let B: String
            let a: String
            let A: String
            let o: String
            let h: String
            let l: String
            let v: String
            let q: String
            let O: Int
            let C: Int
            let F: Int
            let L: Int
            let n: Int
        }

        do {
            let wrapper = try JSONDecoder().decode(CombinedStreamWrapper.self, from: data)
            let dto = wrapper.data

            return AssetDomainModel(
                symbol: dto.s,
                priceChange: dto.p,
                priceChangePercent: dto.P,
                weightedAvgPrice: dto.w,
                prevClosePrice: dto.x,
                lastPrice: dto.c,
                lastQty: dto.Q,
                bidPrice: dto.b,
                bidQty: dto.B,
                askPrice: dto.a,
                askQty: dto.A,
                openPrice: dto.o,
                highPrice: dto.h,
                lowPrice: dto.l,
                volume: dto.v,
                quoteVolume: dto.q,
                openTime: dto.O,
                closeTime: dto.C,
                firstID: dto.F,
                lastID: dto.L,
                count: dto.n
            )
        } catch {
            print("❌ Failed to decode AssetDomainModel: \(error)")
            return nil
        }
    }
}
