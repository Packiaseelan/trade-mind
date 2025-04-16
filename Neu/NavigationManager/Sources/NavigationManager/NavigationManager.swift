import SwiftUI
import Core

/// A class responsible for managing navigation within an application.
/// This class maintains a stack of views and provides methods to manipulate the navigation stack.
public class NavigationManager: ObservableObject, NavigationManagerProtocol {
    @Published public var currentDestination: AnyDestination?
    
    nonisolated(unsafe) public static let shared = NavigationManager()
    
    /// The registry that holds all navigation managers.
    public var registry: NavigationManagerRegistry = NavigationManagerRegistry()
    
    /// A published property that represents the stack of views.
    @Published public var viewStack: [AnyDestination] = []
    
    /// Initializes a new instance of `NavigationManager`.
    public init() {}
    
    /// Register `NavigationManagerRegistry` for feature modules.
    /// - Parameter registry: The registry used to retrieve navigation managers.
    public func moduleRegister(registry: NavigationManagerRegistry) {
        self.registry = registry
    }
    
    /// Pushes a new destination onto the view stack.
    /// - Parameter destination: The destination to push onto the stack.
    public func push(destination: AnyDestination) {
        viewStack.append(destination)
        self.currentDestination = getCurrentDestination()
    }
    
    /// Pops the top destination from the view stack.
    public func pop() {
        guard !viewStack.isEmpty else { return }
        viewStack.removeLast()
        self.currentDestination = getCurrentDestination()
    }
    
    /// Replaces the entire view stack with a new destination.
    /// - Parameter destination: The destination to replace the stack with.
    public func replace(destination: AnyDestination) {
        viewStack = [destination]
        self.currentDestination = getCurrentDestination()
    }
    
    /// Replaces the current top destination with a new destination.
    /// - Parameter destination: The destination to replace the current top destination.
    public func replaceCurrent(destination: AnyDestination) {
        guard !viewStack.isEmpty else { return }
        viewStack[viewStack.count - 1] = destination
        self.currentDestination = getCurrentDestination()
    }
    
    /// Pops all destinations until the root is reached.
    public func popToRoot() {
        guard !viewStack.isEmpty else { return }
        viewStack = [viewStack.first!]
        self.currentDestination = getCurrentDestination()
    }
    
    /// Clears the view stack and navigates to a new destination.
    /// - Parameter destination: The destination to navigate to.
    public func clearStackAndNavigate(to destination: AnyDestination) {
        viewStack = [destination]
        self.currentDestination = getCurrentDestination()
    }
    
    /// Returns the current view based on the top destination in the stack.
    /// - Returns: The current view as an `AnyView`.
    public func currentView() -> AnyView {
        guard let currentDestination = viewStack.last else {
            return AnyView(Text("Invalid View"))
        }
        
        guard let manager = registry.getManager(forKey: currentDestination.module) as? (any ModuleNavigationManagerProtocol) else {
            return AnyView(Text("Invalid Manager"))
        }
        
        return manager.erasedView(for: currentDestination.screen, arguments: currentDestination.arguments)
    }
    
    private func getCurrentDestination() -> AnyDestination? {
        viewStack.last
    }
}
