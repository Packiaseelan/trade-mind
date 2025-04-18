import Core
import Charts
import SwiftUI
import TradeDeskDomain
import TradeDeskUiKit

public struct AssetDetailsView: BaseView {
    @StateObject public var viewModel: AssetDetailsViewModel
    private let arguments: [String: Any]

    public init(viewModel: AssetDetailsViewModel, arguments: [String: Any]) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.arguments = arguments
    }

    public var body: some View {
        VStack {
            if let asset = viewModel.asset {
                headerSection(asset: asset)
            }

            if viewModel.isLoading {
                ProgressView("Loading chart...")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                Picker("Chart Type", selection: $viewModel.selectedChartType) {
                    ForEach(ChartType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Picker("Interval", selection: $viewModel.selectedInterval) {
                    ForEach(KlineInterval.allCases) { interval in
                        Text(interval.label).tag(interval)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                switch viewModel.selectedChartType {
                case .candlestick:
                    CandleChart(smaPrices: viewModel.smaPrices, prices: viewModel.prices)
                case .line:
                    LineChart(prices: viewModel.prices)
                }
            }

            if let asset = viewModel.asset {
                statSection(asset: asset)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .navigationTitle(viewModel.asset?.symbol ?? "Asset Details")
        .onAppear {
            viewModel.onInit(arguments: arguments)
            viewModel.onAppear()
        }
        .onDisappear(perform: viewModel.onDisappear)
    }

    private func headerSection(asset: AssetDomainModel) -> some View {
        let lastPrice = Double(asset.lastPrice) ?? 0.0
        let priceChangePercent = Double(asset.priceChangePercent) ?? 0.0
        let priceColor: Color = priceChangePercent >= 0 ? .green : .red

        return VStack(spacing: 4) {
            Text(asset.symbol)
                .font(.title2)
                .bold()

            Text(String(format: "%.2f", lastPrice))
                .font(.title)
                .foregroundColor(priceColor)

            Text(String(format: "%.2f%%", priceChangePercent))
                .font(.subheadline)
                .foregroundColor(priceColor)
        }
    }

    private func statSection(asset: AssetDomainModel) -> some View {
        VStack(spacing: 8) {
            HStack {
                statCell("High", Double(asset.highPrice) ?? 0.0)
                statCell("Low", Double(asset.lowPrice) ?? 0.0)
            }
            HStack {
                statCell("Open", Double(asset.openPrice) ?? 0.0)
                statCell("Volume", Double(asset.volume) ?? 0.0)
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
