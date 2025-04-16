import SwiftUI
import NavigationManager
import Shared
import Core

class SplashViewModel: ObservableObject {
    private var navigation: NavigationManager

    init(navigationManager: NavigationManager) {
        self.navigation = navigationManager
        startSplashTimer()
    }

    private func startSplashTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let destination = AnyDestination(
                module: ModuleIdentifier.authentication,
                screen: AuthenticationModuleIdentifier.Screen.login
            )
            self.navigation.replace(destination: destination)
        }
    }
}
