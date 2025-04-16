import SwiftUI
import NavigationManager
import Core

struct SplashView: View {
    
    @StateObject private var viewModel: SplashViewModel
    
    init(navigation: NavigationManager) {
        _viewModel = StateObject(wrappedValue: SplashViewModel(navigationManager: navigation))
    }
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.green, Color.yellow, Color.orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Logo image
            Image("TradeMindLogo") // Replace with your asset name
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
    }
}
