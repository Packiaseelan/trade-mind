import Core
import SwiftUI
import Shared
import AuthenticationPresentation

public final class AuthenticationNavigationManager: @preconcurrency ModuleNavigationManagerProtocol {

    public init() {}

    public func navigate(to destination: AuthenticationModuleIdentifier.Screen) { }

    @MainActor
    public func view(for destination: AuthenticationModuleIdentifier.Screen, arguments: [String: AnyHashable]) -> AnyView {
        switch destination {
        case .login:
            return AnyView(Text("Login view"))
 
        }
    }
}
