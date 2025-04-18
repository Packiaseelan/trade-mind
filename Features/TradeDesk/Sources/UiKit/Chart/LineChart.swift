import Charts
import SwiftUI
import TradeDeskDomain

public struct LineChart: View {
    let prices: [CandleData]
    
    public init(prices: [CandleData]) {
        self.prices = prices
    }
    
    public var body: some View {
        Chart(prices) {
            LineMark(
                x: .value("Time", $0.time),
                y: .value("Close", $0.close)
            )
            .interpolationMethod(.monotone)
            .foregroundStyle(.blue)
        }
        .frame(height: 200)
    }
}
