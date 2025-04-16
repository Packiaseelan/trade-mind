/// A protocol that defines the requirements for a module in the system.
///
/// Modules conforming to this protocol are expected to provide their own implementation
/// for registering services or components required for the application's functionality.
public protocol Module {
    
    /// Registers the services provided by the module.
    ///
    /// This method is responsible for setting up the module's dependencies and
    /// making them available for use in the application. Each conforming module
    /// should implement this method to register its specific services.
    func registerServices()
}
