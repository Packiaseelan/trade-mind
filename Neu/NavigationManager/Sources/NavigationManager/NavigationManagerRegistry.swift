import Core

/// A class responsible for registering and retrieving navigation managers.
/// This class acts as a registry for navigation managers conforming to the `ModuleNavigationManagerProtocol`.
public class NavigationManagerRegistry {
    /// A dictionary to store navigation managers with their associated keys.
    private var managers: [String: Any] = [:]

    /// Initializes a new instance of `NavigationManagerRegistry`.
    public init() {}

    /// Registers a navigation manager with a specified key.
    /// - Parameters:
    ///   - manager: The navigation manager to register, conforming to `ModuleNavigationManagerProtocol`.
    ///   - key: A unique key to associate with the navigation manager.
    public func register<Manager: ModuleNavigationManagerProtocol>(
        manager: Manager,
        forKey key: String
    ) {
        managers[key] = manager
    }

    /// Retrieves a navigation manager associated with a specified key.
    /// - Parameter key: The key associated with the desired navigation manager.
    /// - Returns: The navigation manager associated with the key, or `nil` if no manager is found.
    public func getManager(forKey key: String) -> Any? {
        return managers[key]
    }
}
