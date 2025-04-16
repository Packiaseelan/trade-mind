import XCTest

@testable import Core

final class AnyDestinationTests: XCTestCase {
    
    /// Tests initialization with valid parameters.
    func testInitializationWithValidParameters() {
        // Arrange
        let testModule = "TestModule"
        let testScreen = "TestScreen" as AnyHashable
        let testArguments: [String: AnyHashable] = ["key": "value"]
        
        // Act
        let destination = AnyDestination(module: testModule, screen: testScreen, arguments: testArguments)
        
        // Assert
        XCTAssertEqual(destination.module, testModule, "The module should match the provided value.")
        XCTAssertEqual(destination.screen as? String, "TestScreen", "The screen should match the provided value.")
        XCTAssertEqual(destination.arguments["key"] as? String, "value", "The arguments should match the provided value.")
    }
    
    /// Tests initialization with default arguments (empty dictionary).
    func testInitializationWithDefaultArguments() {
        // Arrange
        let testModule = "TestModule"
        let testScreen = "TestScreen" as AnyHashable
        
        // Act
        let destination = AnyDestination(module: testModule, screen: testScreen)
        
        // Assert
        XCTAssertEqual(destination.module, testModule, "The module should match the provided value.")
        XCTAssertEqual(destination.screen as? String, "TestScreen", "The screen should match the provided value.")
        XCTAssertTrue(destination.arguments.isEmpty, "The arguments should be an empty dictionary.")
    }
    
    /// Tests equality for two `AnyDestination` objects with the same values.
    func testEqualityWithEqualDestinations() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value"])
        let destination2 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value"])
        
        // Act & Assert
        XCTAssertEqual(destination1, destination2, "Destinations with the same values should be equal.")
    }
    
    /// Tests inequality for two `AnyDestination` objects with different values.
    func testInequalityWithDifferentDestinations() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value"])
        let destination2 = AnyDestination(module: "TestModule", screen: "DifferentScreen" as AnyHashable, arguments: ["key": "value"])
        
        // Act & Assert
        XCTAssertNotEqual(destination1, destination2, "Destinations with different screens should not be equal.")
    }
    
    /// Tests equality when the arguments differ between two destinations.
    func testInequalityWithDifferentArguments() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value"])
        let destination2 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "differentValue"])
        
        // Act & Assert
        XCTAssertNotEqual(destination1, destination2, "Destinations with different arguments should not be equal.")
    }
    
    /// Tests equality when the arguments dictionary is empty.
    func testEqualityWithEmptyArguments() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable)
        let destination2 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable)
        
        // Act & Assert
        XCTAssertEqual(destination1, destination2, "Destinations with the same module and screen should be equal, even if arguments are empty.")
    }
    
    /// Tests that the `arguments` dictionary allows multiple types of `AnyHashable` values.
    func testArgumentsWithMultipleTypes() {
        // Arrange
        let arguments: [String: AnyHashable] = [
            "stringKey": "stringValue" as AnyHashable,
            "intKey": 123 as AnyHashable,
            "boolKey": true as AnyHashable,
            "arrayKey": [1, 2, 3] as AnyHashable
        ]
        
        let destination = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: arguments)
        
        // Act & Assert
        XCTAssertEqual(destination.arguments["stringKey"] as? String, "stringValue")
        XCTAssertEqual(destination.arguments["intKey"] as? Int, 123)
        XCTAssertEqual(destination.arguments["boolKey"] as? Bool, true)
        XCTAssertEqual(destination.arguments["arrayKey"] as? [Int], [1, 2, 3])
    }
    
    /// Tests equality when `AnyHashable` values have different types but are equivalent.
    func testEqualityWithEquivalentHashables() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value" as AnyHashable])
        let destination2 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value" as AnyHashable])
        
        // Act & Assert
        XCTAssertEqual(destination1, destination2, "Destinations with equivalent `AnyHashable` values should be equal.")
    }
    
    /// Tests that two `AnyDestination` objects with different types for the screen are not equal.
    func testEqualityWithDifferentScreenTypes() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable)
        let destination2 = AnyDestination(module: "TestModule", screen: 123 as AnyHashable)
        
        // Act & Assert
        XCTAssertNotEqual(destination1, destination2, "Destinations with different screen types should not be equal.")
    }
    
    /// Tests hashability for `AnyDestination`.
    func testHashableWithEqualDestinations() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value"])
        let destination2 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value"])
        
        // Act & Assert
        XCTAssertEqual(destination1.hashValue, destination2.hashValue, "Destinations with the same values should have the same hash value.")
    }
    
    /// Tests hashability with different destinations.
    func testHashableWithDifferentDestinations() {
        // Arrange
        let destination1 = AnyDestination(module: "TestModule", screen: "TestScreen" as AnyHashable, arguments: ["key": "value"])
        let destination2 = AnyDestination(module: "TestModule", screen: "DifferentScreen" as AnyHashable, arguments: ["key": "value"])
        
        // Act & Assert
        XCTAssertNotEqual(destination1.hashValue, destination2.hashValue, "Destinations with different screens should have different hash values.")
    }
}
