import Foundation

public struct MovingAverageData: Identifiable {
    public var id: String { time.description }
    public let time: Date
    public let value: Double
    
    public init(time: Date, value: Double) {
        self.time = time
        self.value = value
    }
}
