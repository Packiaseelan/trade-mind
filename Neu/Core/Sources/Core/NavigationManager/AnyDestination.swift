/// A structure that represents a destination for navigation within an application.
///
/// `AnyDestination` encapsulates the module, screen, and additional arguments needed for navigation purposes.
/// It is designed to be flexible, allowing any type of screen and arguments to be passed, as long as they conform to `AnyHashable`.
///
/// This can be useful for dynamic navigation, where different screens may require different arguments based on the context of navigation.

public struct AnyDestination: Hashable {
    
    /// The module identifier associated with the destination.
    ///
    /// This represents the module where the destination screen resides, which can be used for routing or module-specific navigation.
    public let module: String
    
    /// The destination screen, which can be any type that conforms to `AnyHashable`.
    ///
    /// This allows flexibility in specifying which screen should be navigated to, supporting any type that conforms to `AnyHashable`.
    public let screen: AnyHashable
    
    /// Additional arguments passed for the navigation.
    ///
    /// This dictionary allows passing extra data needed for the navigation to the screen.
    /// The key-value pairs must conform to `String: AnyHashable`, allowing a wide range of possible argument types.
    public let arguments: [String: AnyHashable]
    
    /// Initializes a new `AnyDestination` with the provided module, screen, and optional arguments.
    ///
    /// - Parameters:
    ///   - module: The module identifier for the destination.
    ///   - screen: The destination screen, which can be any type that conforms to `AnyHashable`.
    ///   - arguments: A dictionary of additional arguments to pass for navigation. Defaults to an empty dictionary.
    public init(module: String, screen: AnyHashable, arguments: [String: AnyHashable] = [:]) {
        self.module = module
        self.screen = screen
        self.arguments = arguments
    }
}
