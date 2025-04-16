import XCTest

@testable import Core

final class CoreInitializationParamsTests: XCTestCase {
    
    /// Tests initialization with valid parameters.
    func testInitializationWithValidParameters() {
        // Arrange
        let testIdentifier = "testIdentifier"
        let testModule = MockModule()
        
        // Act
        let params = CoreInitializationParams(identifier: testIdentifier, module: testModule)
        
        // Assert
        XCTAssertEqual(params.identifier, testIdentifier, "The identifier should match the provided value.")
        XCTAssert(params.module is MockModule, "The module should be of type MockModule.")
    }
    
    /// Tests initialization with an empty identifier.
    func testInitializationWithEmptyIdentifier() {
        // Arrange
        let emptyIdentifier = ""
        let testModule = MockModule()
        
        // Act
        let params = CoreInitializationParams(identifier: emptyIdentifier, module: testModule)
        
        // Assert
        XCTAssertEqual(params.identifier, emptyIdentifier, "The identifier should allow empty strings.")
        XCTAssert(params.module is MockModule, "The module should be of type MockModule.")
    }
    
    /// Tests initialization with a very long identifier string.
    func testInitializationWithLongIdentifier() {
        // Arrange
        let longIdentifier = String(repeating: "a", count: 10_000) // A long string
        let testModule = MockModule()
        
        // Act
        let params = CoreInitializationParams(identifier: longIdentifier, module: testModule)
        
        // Assert
        XCTAssertEqual(params.identifier, longIdentifier, "The identifier should support long strings.")
        XCTAssert(params.module is MockModule, "The module should be of type MockModule.")
    }
    
    /// Tests initialization with special characters in the identifier.
    func testInitializationWithSpecialCharacters() {
        // Arrange
        let specialCharacterIdentifier = "!@#$%^&*()_+-=[]{}|;:',.<>?/`~"
        let testModule = MockModule()
        
        // Act
        let params = CoreInitializationParams(identifier: specialCharacterIdentifier, module: testModule)
        
        // Assert
        XCTAssertEqual(params.identifier, specialCharacterIdentifier, "The identifier should support special characters.")
        XCTAssert(params.module is MockModule, "The module should be of type MockModule.")
    }
    
    /// Tests initialization with unicode characters in the identifier.
    func testInitializationWithUnicodeCharacters() {
        // Arrange
        let unicodeIdentifier = "你好世界🌍"
        let testModule = MockModule()
        
        // Act
        let params = CoreInitializationParams(identifier: unicodeIdentifier, module: testModule)
        
        // Assert
        XCTAssertEqual(params.identifier, unicodeIdentifier, "The identifier should support unicode characters.")
        XCTAssert(params.module is MockModule, "The module should be of type MockModule.")
    }
}
