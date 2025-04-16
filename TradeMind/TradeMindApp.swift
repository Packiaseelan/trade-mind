import SwiftUI
import SwiftData

@main
struct TradeMindApp: App {
    /// An instance of `AppInitializer` used to perform initial setup tasks for the app.
    private let initializer: AppInitializer = AppInitializer()
    
    /// Initializes a new instance of `TradeMindApp`.
    /// This initializer sets up the navigation manager and performs initial app setup.
    init() {
        // Perform initial setup tasks using the initializer.
        self.initializer.initialize()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppNavigationView()
            }
        }
    }
}
