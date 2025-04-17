import Core
import SwiftUI

public struct AssetDetailsView: BaseView {
    @StateObject public var viewModel: AssetDetailsViewModel
    
    public init(viewModel: AssetDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Text("Asset Details View")
    }
}
