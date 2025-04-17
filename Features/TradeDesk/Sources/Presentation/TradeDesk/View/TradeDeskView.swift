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
                TextField("Search by symbol...", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView("Loading market data...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                } else {
                    if !viewModel.filteredAssets.isEmpty {
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.filteredAssets, id: \.id) { asset in
                                    AssetRowView(asset: asset)
                                        .onTapGesture {
                                            viewModel.onSelectAsset(asset)
                                        }
                                }
                            }
                        }
                        .refreshable{ viewModel.onPullToRefresh() }
                    } else {
                        Text("No matching assets found...")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            .navigationTitle("TradeDesk")
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
        }
    }
}
