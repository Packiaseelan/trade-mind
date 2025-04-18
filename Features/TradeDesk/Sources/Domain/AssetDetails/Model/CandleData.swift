import Foundation

public struct CandleData: Identifiable {
    public let id = UUID()
    public let time: Date
    public let open: Double
    public let high: Double
    public let low: Double
    public let close: Double
    public let volume: Double

    public init?(from elements: [CandleDomainModelElement]) {
        guard
            elements.count >= 6,
            case let .integer(openTimeInt) = elements[0],
            case let .string(openStr) = elements[1],
            case let .string(highStr) = elements[2],
            case let .string(lowStr) = elements[3],
            case let .string(closeStr) = elements[4],
            case let .string(volumeStr) = elements[5],
            let open = Double(openStr),
            let high = Double(highStr),
            let low = Double(lowStr),
            let close = Double(closeStr),
            let volume = Double(volumeStr)
        else {
            return nil
        }

        self.time = Date(timeIntervalSince1970: TimeInterval(openTimeInt / 1000))
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
    }
}
