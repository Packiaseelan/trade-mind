import Core
import SwiftUI
import Shared
import TradeDeskPresentation

public final class TradeDeskNavigationManager: @preconcurrency ModuleNavigationManagerProtocol {

    public init() {}

    public func navigate(to destination: TradeDeskModuleIdentifier.Screen) { }

    @MainActor
    public func view(for destination: TradeDeskModuleIdentifier.Screen, arguments: [String: AnyHashable]) -> AnyView {
        switch destination {
        case .landing:
            return AnyView(LandingView())
            
        case .assetDetails:
            let viewModel = DIContainer.container.resolve(AssetDetailsViewModel.self)!
            return AnyView(AssetDetailsView(viewModel: viewModel))
 
        }
    }
}
