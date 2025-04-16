import Core
import Shared
import NetworkManager
import NavigationManager
import Authentication

/// A class responsible for initializing the application.
/// This class sets up necessary services and registers dependencies for various modules,
/// ensuring that the application is properly configured before it starts running.
class AppInitializer {
    
    /// Initializes the application by calling setup methods.
    /// This method orchestrates the initialization process, ensuring that all necessary
    /// components and dependencies are registered and ready for use.
    func initialize() {
        appInitializers()
        registerModuleDependencies()
    }
    
    /// Sets up application-wide initializers.
    /// This private method is responsible for registering core services, such as the network manager,
    /// which are essential for the application's operation.
    private func appInitializers() {
        // Register the Network Manager with the dependency injection container.
        let baseUrl = ConfigManager.shared.baseUrl
        DIContainer.container.register(NetworkManagerProtocol.self, name: ModuleIdentifier.network) { _ in
            NetworkManager(baseURL: baseUrl)
        }
        
        /// Register the Module navigation managers to the `NavigationManager`.
        let registry = NavigationRegistryProvider.createRegistry()
        NavigationManager.shared.moduleRegister(registry: registry)
    }
    
    /// Registers dependencies for various modules.
    /// This private method creates instances of modules and registers their dependencies
    /// using the core system, ensuring that each module is properly configured.
    private func registerModuleDependencies() {
        // Initialize the core system.
        let core = Core()
        
        // Define the modules to be registered.
        let modules = [
            CoreInitializationParams(
                identifier: ModuleIdentifier.authentication,
                module: AuthenticationModule()
            )
        ]
        
        // Register the modules with the core system.
        core.registerMinimalDependencies(modules: modules)
    }
}
