import XCTest
import Core

@testable import NavigationManager

final class NavigationManagerTests: XCTestCase {
    
    var navigationManager: NavigationManager!
    var testDestination1: AnyDestination!
    var testDestination2: AnyDestination!
    
    override func setUp() {
        super.setUp()
        navigationManager = NavigationManager()
        testDestination1 = AnyDestination(module: "test1", screen: "Payload1", arguments: [:])
        testDestination2 = AnyDestination(module: "test2", screen: "Payload2", arguments: [:])
    }
    
    override func tearDown() {
        navigationManager = nil
        testDestination1 = nil
        testDestination2 = nil
        super.tearDown()
    }
    
    func testPushDestination() {
        navigationManager.push(destination: testDestination1)
        XCTAssertEqual(navigationManager.viewStack.count, 1)
        XCTAssertEqual(navigationManager.currentDestination?.module, "test1")
    }
    
    func testPopDestination() {
        navigationManager.push(destination: testDestination1)
        navigationManager.push(destination: testDestination2)
        navigationManager.pop()
        XCTAssertEqual(navigationManager.viewStack.count, 1)
        XCTAssertEqual(navigationManager.currentDestination?.module, "test1")
    }
    
    func testReplaceDestination() {
        navigationManager.push(destination: testDestination1)
        navigationManager.replace(destination: testDestination2)
        XCTAssertEqual(navigationManager.viewStack.count, 1)
        XCTAssertEqual(navigationManager.currentDestination?.module, "test2")
    }
    
    func testReplaceCurrentDestination() {
        navigationManager.push(destination: testDestination1)
        navigationManager.replaceCurrent(destination: testDestination2)
        XCTAssertEqual(navigationManager.viewStack.count, 1)
        XCTAssertEqual(navigationManager.currentDestination?.module, "test2")
    }
    
    func testPopToRoot() {
        navigationManager.push(destination: testDestination1)
        navigationManager.push(destination: testDestination2)
        navigationManager.popToRoot()
        XCTAssertEqual(navigationManager.viewStack.count, 1)
        XCTAssertEqual(navigationManager.currentDestination?.module, "test1")
    }
    
    func testClearStackAndNavigate() {
        navigationManager.push(destination: testDestination1)
        navigationManager.clearStackAndNavigate(to: testDestination2)
        XCTAssertEqual(navigationManager.viewStack.count, 1)
        XCTAssertEqual(navigationManager.currentDestination?.module, "test2")
    }
    
    func testCurrentView() {
        // Assuming you have a mock manager that returns a specific view for testing
        navigationManager.push(destination: testDestination1)
        let currentView = navigationManager.currentView()
        // Check if currentView is the expected view
        // This part depends on how your `erasedView` method is implemented
    }
}
