import SwiftUI

/// A protocol that defines the requirements for a navigation manager in a SwiftUI application.
/// This protocol extends `ObservableObject`, allowing conforming classes to manage and publish changes
/// to the navigation stack, facilitating dynamic and responsive navigation within the app.
public protocol NavigationManagerProtocol {
    
    /// A stack of destinations representing the current navigation path.
    /// This property is used to track the sequence of views in the navigation stack,
    /// enabling navigation actions such as push, pop, and replace.
    var viewStack: [AnyDestination] { get set }
    
    /// The current destination at the top of the navigation stack.
    /// This computed property provides access to the view currently being displayed,
    /// or `nil` if the stack is empty.
    var currentDestination: AnyDestination? { get }
    
    /// Pushes a new destination onto the navigation stack.
    /// - Parameter destination: The destination to be added to the stack.
    /// This method is used to navigate to a new view by adding it to the top of the stack.
    func push(destination: AnyDestination)
    
    /// Pops the top destination from the navigation stack.
    /// This method is used to navigate back to the previous view by removing the current top view.
    func pop()
    
    /// Replaces the entire navigation stack with a new destination.
    /// - Parameter destination: The destination to replace the stack with.
    /// This method is used to reset the navigation path to a single view.
    func replace(destination: AnyDestination)
    
    /// Replaces the current top destination with a new destination.
    /// - Parameter destination: The destination to replace the current top view.
    /// This method is used to update the current view without altering the rest of the stack.
    func replaceCurrent(destination: AnyDestination)
    
    /// Pops all destinations until the root is reached.
    /// This method is used to navigate back to the root view, clearing all intermediate views.
    func popToRoot()
    
    /// Clears the navigation stack and navigates to a new destination.
    /// - Parameter destination: The destination to navigate to after clearing the stack.
    /// This method is used to reset the navigation path and start with a new view.
    func clearStackAndNavigate(to destination: AnyDestination)
}
