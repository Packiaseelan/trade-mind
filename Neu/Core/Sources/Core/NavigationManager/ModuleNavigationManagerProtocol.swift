import SwiftUI

/// A protocol that defines the requirements for a module navigation manager.
/// This protocol allows for navigation to different destinations and provides views for those destinations.
public protocol ModuleNavigationManagerProtocol {
    /// The type of destination that the navigation manager can handle.
    associatedtype DestinationType: Hashable
    
    /// Navigates to a specified destination.
    /// - Parameter destination: The destination to navigate to.
    func navigate(to destination: DestinationType)
    
    /// Provides a view for a specified destination with additional arguments.
    /// - Parameters:
    ///   - destination: The destination for which to provide a view.
    ///   - arguments: Additional arguments to configure the view.
    /// - Returns: A SwiftUI view for the specified destination.
    func view(for destination: DestinationType, arguments: [String: AnyHashable]) -> AnyView
    
    /// Provides a type-erased view for dynamic navigation.
    /// - Parameters:
    ///   - destination: The destination for which to provide a view, type-erased to `AnyHashable`.
    ///   - arguments: Additional arguments to configure the view.
    /// - Returns: A SwiftUI view for the specified destination.
    func erasedView(for destination: AnyHashable, arguments: [String: AnyHashable]) -> AnyView
}

/// Default implementation of the `erasedView` method for the `ModuleNavigationManagerProtocol`.
extension ModuleNavigationManagerProtocol {
    public func erasedView(for destination: AnyHashable, arguments: [String: AnyHashable]) -> AnyView {
        // Attempt to cast the type-erased destination to the specific destination type.
        guard let typedDestination = destination as? DestinationType else {
            // Return a default view if the cast fails.
            return AnyView(Text("Invalid Destination"))
        }
        // Return the view for the typed destination.
        return view(for: typedDestination, arguments: arguments)
    }
}
