import Core
import Charts
import SwiftUI

public struct AssetDetailsView: BaseView {
    @StateObject public var viewModel: AssetDetailsViewModel
    
    public init(viewModel: AssetDetailsViewModel, arguments: [String: Any]) {
        viewModel.onInit(arguments: arguments)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack {
            headerSection
            if viewModel.isLoading {
                ProgressView("Loading chart...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Picker("Interval", selection: $viewModel.selectedInterval) {
                    ForEach(KlineInterval.allCases) { interval in
                        Text(interval.label).tag(interval)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Chart(viewModel.prices) {
                    LineMark(
                        x: .value("Time", $0.time),
                        y: .value("Close", $0.close)
                    )
                    .interpolationMethod(.monotone)
                    .foregroundStyle(.blue)
                }
                .frame(height: 200)
            }
            statSection
        }
        .navigationTitle(viewModel.asset!.symbol)
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}

extension AssetDetailsView {
    private var lastPriceText: String {
        let lastPrice = Double(viewModel.asset!.lastPrice) ?? 0.0
        return String(format: "%.2f", lastPrice)
    }
    
    private var priceChangeColor: Color {
        let priceChange = Double(viewModel.asset!.priceChangePercent) ?? 0.0
        return priceChange >= 0 ? .green : .red
    }
    
    private var priceChangePercentText: String {
        let priceChangePercent = Double(viewModel.asset!.priceChangePercent) ?? 0.0
        return String(format: "%.2f", priceChangePercent)
    }
    
    private var headerSection: some View {
        VStack(spacing: 4) {
            Text(viewModel.asset!.symbol)
                .font(.title2)
                .bold()
            
            Text(lastPriceText)
                .font(.title)
                .foregroundColor(priceChangeColor)
            
            Text("\(priceChangePercentText)%")
                .font(.subheadline)
                .foregroundColor(priceChangeColor)
        }
    }
    
    
    private var statSection: some View {
        VStack(spacing: 8) {
            HStack {
                statCell("High", Double(viewModel.asset!.highPrice) ?? 0.0)
                statCell("Low", Double(viewModel.asset!.lowPrice) ?? 0.0)
            }
            HStack {
                statCell("Open", Double(viewModel.asset!.openPrice) ?? 0.0)
                statCell("Volume", Double(viewModel.asset!.volume) ?? 0.0)
            }
        }
    }
    
    private func statCell(_ title: String, _ value: Double) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text("\(value, specifier: "%.2f")")
                .font(.body)
        }
        .frame(maxWidth: .infinity)
    }
}
