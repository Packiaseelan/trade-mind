import Core
import TradeDeskMapper
import Shared

/// A class representing the Characters module within the application.
/// This class is responsible for registering services related to character functionalities,
/// particularly focusing on the student list feature. It conforms to the `Module` protocol,
/// which requires the implementation of the `registerServices` method.
public class TradeDeskModule: Module {
    
    /// Initializes a new instance of `CharactersModule`.
    /// This initializer sets up the module without any initial configuration.
    public init () {}
    
    /// Registers services for the Characters module.
    /// This method is responsible for setting up the necessary services and dependencies
    /// related to character functionalities, ensuring they are available for use throughout the application.
    public func registerServices() {
        TradeDeskMapperModule().registerServices()
    }
}
