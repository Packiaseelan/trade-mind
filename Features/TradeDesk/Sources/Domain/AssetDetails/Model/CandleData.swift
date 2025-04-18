import Foundation

public struct CandleData: Identifiable {
    public let id = UUID()
    public let time: Date
    public let close: Double

    public init?(from elements: [CandleDomainModelElement]) {
        guard
            elements.count >= 5,
            case let .integer(openTimeMs) = elements[0],
            case let .string(closeStr) = elements[4],
            let close = Double(closeStr)
        else {
            return nil
        }

        self.time = Date(timeIntervalSince1970: TimeInterval(openTimeMs) / 1000)
        self.close = close
    }
}
