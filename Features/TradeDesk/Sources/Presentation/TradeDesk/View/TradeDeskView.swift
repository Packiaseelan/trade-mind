import SwiftUI
import TradeDeskDomain
import TradeDeskUiKit

struct TradeDeskView: View {
    @StateObject public var viewModel: TradeDeskViewModel
    
    public init(viewModel: TradeDeskViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading market data...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.assets, id: \.id) { asset in
                                AssetRowView(asset: asset)
                            }
                        }
                    }
                }
            }
            .navigationTitle("TradeDesk")
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
        }
    }
}
