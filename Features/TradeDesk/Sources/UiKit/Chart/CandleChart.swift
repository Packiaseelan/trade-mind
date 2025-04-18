import Charts
import SwiftUI
import TradeDeskDomain

public struct CandleChart: View {
    let smaPrices: [MovingAverageData]
    let prices: [CandleData]
    
    public init(smaPrices: [MovingAverageData], prices: [CandleData]) {
        self.smaPrices = smaPrices
        self.prices = prices
    }
    
    public var body: some View {
        Chart {
            ForEach(prices) { candle in
                // Wick: high to low
                RuleMark(
                    x: .value("Time", candle.time),
                    yStart: .value("Low", candle.low),
                    yEnd: .value("High", candle.high)
                )
                .foregroundStyle(candle.close >= candle.open ? .green : .red)

                // Body: open to close
                RectangleMark(
                    x: .value("Time", candle.time),
                    yStart: .value("Open", max(candle.open, candle.close)),
                    yEnd: .value("Close", min(candle.open, candle.close)),
                    width: .fixed(5)
                )
                .foregroundStyle(candle.close >= candle.open ? .green : .red)
            }

            // 🧮 SMA Overlay
            ForEach(smaPrices) { avg in
                LineMark(
                    x: .value("Time", avg.time),
                    y: .value("SMA", avg.value)
                )
                .foregroundStyle(.blue)
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 1.5))
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 5)) { value in
                AxisValueLabel(format: .dateTime.hour().minute(), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 250)
        .padding(.horizontal)
    }
}
