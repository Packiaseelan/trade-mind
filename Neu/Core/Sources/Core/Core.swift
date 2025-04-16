/// A class responsible for managing the core functionality of an application,
/// particularly the registration of dependencies for various modules.
/// This class serves as a central point for initializing and setting up modules
/// by registering their services and dependencies.
public class Core {
    
    /// Initializes a new instance of the `Core` class.
    /// This initializer sets up the core system without any initial configuration.
    public init() {}
    
    /// Registers minimal dependencies for a given list of modules.
    /// This method is intended to be called during the application's startup process
    /// to ensure that all necessary services are registered and available.
    /// - Parameter modules: An array of `CoreInitializationParams` containing the modules to be registered.
    public func registerMinimalDependencies(modules: [CoreInitializationParams]) {
        registerModules(modules: modules)
    }
    
    /// Registers the services for each module in the provided list.
    /// This private method iterates over the modules and calls their `registerServices` method
    /// to register their specific dependencies.
    /// - Parameter modules: An array of `CoreInitializationParams` containing the modules to be registered.
    private func registerModules(modules: [CoreInitializationParams]) {
        for module in modules {
            module.module.registerServices()
        }
    }
}
