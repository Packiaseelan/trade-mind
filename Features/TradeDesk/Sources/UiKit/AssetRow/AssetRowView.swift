import SwiftUI
import TradeDeskDomain

public struct AssetRowView: View {
    var asset: AssetDomainModel
    
    private var priceChangeText: String {
        let priceChange = Double(asset.priceChange) ?? 0.0
        return String(format: "%.2f", priceChange)
    }
    
    private var priceChangeColor: Color {
        let priceChange = Double(asset.priceChange) ?? 0.0
        return priceChange >= 0 ? .green : .red
    }
    
    private var price: String {
        return asset.lastPrice
    }
    
    public init(asset: AssetDomainModel) {
        self.asset = asset
    }
    
    public var body: some View {
        HStack {
            // Asset Symbol and Name
            VStack(alignment: .leading) {
                Text(asset.symbol)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                
                HStack {
                    Text(price)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(priceChangeText)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(priceChangeColor)
                        .padding(.leading, 8)
                        .transition(.scale)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Volume and Additional Info
            VStack(alignment: .trailing) {
                Text("Volume: \(asset.volume)")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text("High: \(asset.highPrice)")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(12)
        .shadow(radius: 8, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
        .animation(.easeInOut(duration: 0.3), value: priceChangeText)  // Smooth animation for price change
    }
}
