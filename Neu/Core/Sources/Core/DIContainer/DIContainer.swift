import Swinject

/// A class responsible for managing a dependency injection container.
/// This class utilizes the Swinject library to provide a centralized container
/// for registering and resolving dependencies throughout the application.
public class DIContainer {
    
    /// A static instance of the Swinject container.
    /// This container is used to register and resolve dependencies.
    /// The `nonisolated(unsafe)` attribute indicates that this property is accessible
    /// from any actor context without isolation, which is useful for global access.
    nonisolated(unsafe) public static let container = Swinject.Container()
    
    /// Private initializer to prevent instantiation.
    /// This class is intended to be used as a static container, so instantiation is not allowed.
    private init() { }
}
