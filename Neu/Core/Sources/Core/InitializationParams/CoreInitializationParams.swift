/// A structure that encapsulates the core initialization parameters for a module.
public struct CoreInitializationParams {
    /// A unique identifier for the instance.
    let identifier: String
    
    /// The module associated with this initialization.
    let module: Module
    
    /// Creates a new instance of `CoreInitializationParams`.
    ///
    /// - Parameters:
    ///   - identifier: A unique string used to identify this instance.
    ///   - module: The module object associated with this instance.
    public init(identifier: String, module: Module) {
        self.identifier = identifier
        self.module = module
    }
}
