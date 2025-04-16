import SwiftUI
import TradeDeskDomain

public struct AssetRowView: View {
    let asset: AssetDomainModel

    @State private var previousPrice: Double?
    @State private var flashColor: Color = .clear

    var price: Double? {
        Double(asset.lastPrice)
    }

    var changePercent: Double {
        Double(asset.priceChangePercent) ?? 0
    }

    var isPositive: Bool {
        changePercent >= 0
    }
    
    public init(asset: AssetDomainModel) {
        self.asset = asset
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(flashColor, lineWidth: 2)
                        .animation(.easeInOut(duration: 0.3), value: flashColor)
                )

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(asset.symbol)
                        .font(.title3.bold())
                        .foregroundColor(.primary)

                    Spacer()

                    if let currentPrice = price {
                        Text(String(format: "$%.2f", currentPrice))
                            .font(.title3)
                            .foregroundColor(.primary)
                            .onAppear {
                                previousPrice = currentPrice
                            }
                            .onChange(of: currentPrice) { newValue in
                                guard let oldValue = previousPrice else {
                                    previousPrice = newValue
                                    return
                                }

                                if newValue > oldValue {
                                    flashColor = .green
                                } else if newValue < oldValue {
                                    flashColor = .red
                                }

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    flashColor = .clear
                                }

                                previousPrice = newValue
                            }
                    }
                }

                HStack(spacing: 12) {
                    Label {
                        Text("24h: \(asset.priceChange)")
                    } icon: {
                        Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                    }
                    .font(.caption)
                    .foregroundColor(isPositive ? .green : .red)

                    Text("\(String(format: "%.2f", changePercent))%")
                        .font(.caption.bold())
                        .foregroundColor(isPositive ? .green : .red)

                    Spacer()

                    Text("Vol: \(asset.volume)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
