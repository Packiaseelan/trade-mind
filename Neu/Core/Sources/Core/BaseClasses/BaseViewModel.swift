import Foundation

/// A protocol that defines the requirements for a base view model in a SwiftUI application.
/// This protocol is designed to manage the state and logic associated with a view,
/// providing a standardized interface for handling common view model responsibilities.
public protocol BaseViewModel: ObservableObject {
    /// A Boolean property indicating whether a loading process is ongoing.
    /// This property can be used to show or hide loading indicators in the view.
    var isLoading: Bool { get set }
    
    /// An optional string property for storing error messages.
    /// This property can be used to display error messages to the user.
    var errorMessage: String? { get set }
    
    /// A method called when the view appears.
    /// This method can be used to initiate data fetching or other setup tasks.
    func onAppear()
    
    /// A method called when the view disappears.
    /// This method can be used to perform cleanup tasks or save state.
    func onDisappear()
    
    /// A method called when the view initialise.
    /// This method can be used to perform initialise the arguments to viewmodel.
    func onInit(arguments: [String: Any])
}
