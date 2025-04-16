import SwiftUI
import Core
import NavigationManager

struct AppNavigationView: View {
    @State private var destinationChanges: Bool = false
    @ObservedObject private var navigation = NavigationManager.shared
    
    var body: some View {
        VStack {
            // Check if viewStack is empty, show SplashView if true, else show the current screen
            if navigation.viewStack.isEmpty {
                SplashView(navigation: navigation)
            } else {
                if let currentDestination = navigation.viewStack.last {
                    CurrentView(destination: currentDestination, navigation: navigation)
                } else {
                    Text("Error: No destination found.")
                }
            }
        }
        .animation(.easeInOut, value: navigation.viewStack)
    }
}

public struct CurrentView: View {
    private let destination: AnyDestination
    private var navigation: NavigationManager
    
    public init(destination: AnyDestination, navigation: NavigationManager) {
        self.destination = destination
        self.navigation = navigation
    }

    public var body: some View {
        Group {
            if let manager = navigation.registry.getManager(forKey: destination.module) as? (any ModuleNavigationManagerProtocol) {
                manager.erasedView(for: destination.screen, arguments: destination.arguments)
            } else {
                Text("Error: Manager not found for key '\(destination.module)'")
                    .foregroundColor(.red)
            }
        }
        .transition(.opacity) // Optional: Smooth transition between views
    }
}
