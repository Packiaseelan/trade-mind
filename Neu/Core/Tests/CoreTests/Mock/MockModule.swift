import XCTest

@testable import Core

/// A mock implementation of the `Module` protocol for testing purposes.
class MockModule: Module {
    var isRegisterServicesCalled = false

    func registerServices() {
        isRegisterServicesCalled = true
    }
}
