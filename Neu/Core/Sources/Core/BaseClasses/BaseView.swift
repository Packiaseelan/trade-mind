import SwiftUI

/// A protocol that defines the requirements for a base view in a SwiftUI application.
/// This protocol ensures that each view is associated with a specific view model,
/// facilitating a clear separation of concerns and promoting the MVVM architecture.
public protocol BaseView: View {
    /// The type of view model associated with the view.
    /// This associated type must conform to `BaseViewModel`, ensuring that the view model
    /// adheres to a common interface or functionality.
    associatedtype ViewModel: BaseViewModel
    
    /// The view model instance associated with the view.
    /// This property provides access to the view model, allowing the view to bind to
    /// observable properties and respond to changes.
    var viewModel: ViewModel { get }
}
