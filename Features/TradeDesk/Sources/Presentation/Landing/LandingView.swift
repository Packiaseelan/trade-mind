import Core
import SwiftUI

public struct LandingView: View {
    
    public init() {}
    
    public var body: some View {
        TabView {
            TradeDeskView1()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            MarketView()
                .tabItem {
                    Label("Market", systemImage: "chart.line.uptrend.xyaxis")
                }

            SignalView()
                .tabItem {
                    Label("AI", systemImage: "brain.head.profile")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}


struct TradeDeskView1: View {
    let viewModel = DIContainer.container.resolve(TradeDeskViewModel.self)!
    var body: some View {
        TradeDeskView(viewModel: viewModel)
    }
}


struct MarketView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Market")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            .navigationTitle("Market")
        }
    }
}

struct SignalView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("AI Signals")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            .navigationTitle("AI Signals")
        }
    }
}


struct HistoryView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Trade History")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            .navigationTitle("Trade History")
        }
    }
}


struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings")
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}
