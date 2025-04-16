import XCTest

@testable import Core

final class NetworkRequestTests: XCTestCase {
    
    /// Tests initialization with all parameters provided.
    func testInitializationWithAllParameters() {
        // Arrange
        let path = "/users"
        let method = HTTPMethod.get // Example, ensure the enum exists in your code
        let headers: [String: String] = ["Content-Type": "application/json"]
        let body = Data("Sample body".utf8)
        let queryParameters: [String: String] = ["search": "JohnDoe", "page": "1"]
        
        // Act
        let request = NetworkRequest(path: path, method: method, headers: headers, body: body, queryParameters: queryParameters)
        
        // Assert
        XCTAssertEqual(request.path, path, "The path should match the provided value.")
        XCTAssertEqual(request.method, method, "The method should match the provided value.")
        XCTAssertEqual(request.headers, headers, "The headers should match the provided value.")
        XCTAssertEqual(request.body, body, "The body should match the provided value.")
        XCTAssertEqual(request.queryParameters, queryParameters, "The query parameters should match the provided value.")
    }
    
    /// Tests initialization with default values for optional parameters.
    func testInitializationWithDefaultParameters() {
        // Arrange
        let path = "/users"
        let method = HTTPMethod.get // Example
        
        // Act
        let request = NetworkRequest(path: path, method: method)
        
        // Assert
        XCTAssertEqual(request.path, path, "The path should match the provided value.")
        XCTAssertEqual(request.method, method, "The method should match the provided value.")
        XCTAssertNil(request.headers, "The headers should be nil.")
        XCTAssertNil(request.body, "The body should be nil.")
        XCTAssertNil(request.queryParameters, "The query parameters should be nil.")
    }
    
    /// Tests that the `headers` parameter is optional.
    func testInitializationWithHeadersOnly() {
        // Arrange
        let path = "/users"
        let method = HTTPMethod.get
        let headers: [String: String] = ["Authorization": "Bearer token"]
        
        // Act
        let request = NetworkRequest(path: path, method: method, headers: headers)
        
        // Assert
        XCTAssertEqual(request.path, path, "The path should match the provided value.")
        XCTAssertEqual(request.method, method, "The method should match the provided value.")
        XCTAssertEqual(request.headers, headers, "The headers should match the provided value.")
        XCTAssertNil(request.body, "The body should be nil.")
        XCTAssertNil(request.queryParameters, "The query parameters should be nil.")
    }
    
    /// Tests that the `body` parameter is optional.
    func testInitializationWithBodyOnly() {
        // Arrange
        let path = "/users"
        let method = HTTPMethod.post // Typically, `POST` requests have a body
        let body = Data("Sample body".utf8)
        
        // Act
        let request = NetworkRequest(path: path, method: method, body: body)
        
        // Assert
        XCTAssertEqual(request.path, path, "The path should match the provided value.")
        XCTAssertEqual(request.method, method, "The method should match the provided value.")
        XCTAssertEqual(request.body, body, "The body should match the provided value.")
        XCTAssertNil(request.headers, "The headers should be nil.")
        XCTAssertNil(request.queryParameters, "The query parameters should be nil.")
    }
    
    /// Tests that the `queryParameters` parameter is optional.
    func testInitializationWithQueryParametersOnly() {
        // Arrange
        let path = "/users"
        let method = HTTPMethod.get
        let queryParameters: [String: String] = ["page": "1", "search": "JohnDoe"]
        
        // Act
        let request = NetworkRequest(path: path, method: method, queryParameters: queryParameters)
        
        // Assert
        XCTAssertEqual(request.path, path, "The path should match the provided value.")
        XCTAssertEqual(request.method, method, "The method should match the provided value.")
        XCTAssertEqual(request.queryParameters, queryParameters, "The query parameters should match the provided value.")
        XCTAssertNil(request.headers, "The headers should be nil.")
        XCTAssertNil(request.body, "The body should be nil.")
    }
    
    /// Tests that `NetworkRequest` correctly ignores `nil` values for optional parameters.
    func testInitializationWithNilValuesForOptionalParameters() {
        // Arrange
        let path = "/users"
        let method = HTTPMethod.get
        
        // Act
        let request = NetworkRequest(path: path, method: method, headers: nil, body: nil, queryParameters: nil)
        
        // Assert
        XCTAssertEqual(request.path, path, "The path should match the provided value.")
        XCTAssertEqual(request.method, method, "The method should match the provided value.")
        XCTAssertNil(request.headers, "The headers should be nil.")
        XCTAssertNil(request.body, "The body should be nil.")
        XCTAssertNil(request.queryParameters, "The query parameters should be nil.")
    }
    
    /// Tests the equality of two `NetworkRequest` instances with identical values.
    func testEqualityWithEqualRequests() {
        // Arrange
        let headers: [String: String] = ["Authorization": "Bearer token"]
        let body = Data("Sample body".utf8)
        let queryParameters: [String: String] = ["search": "JohnDoe"]
        
        let request1 = NetworkRequest(path: "/users", method: HTTPMethod.get, headers: headers, body: body, queryParameters: queryParameters)
        let request2 = NetworkRequest(path: "/users", method: HTTPMethod.get, headers: headers, body: body, queryParameters: queryParameters)
        
        // Act & Assert
        XCTAssertEqual(request1, request2, "Requests with the same parameters should be equal.")
    }
    
    /// Tests the inequality of two `NetworkRequest` instances with different values.
    func testInequalityWithDifferentRequests() {
        // Arrange
        let request1 = NetworkRequest(path: "/users", method: HTTPMethod.get, headers: nil, body: nil, queryParameters: nil)
        let request2 = NetworkRequest(path: "/users", method: HTTPMethod.post, headers: nil, body: nil, queryParameters: nil)
        
        // Act & Assert
        XCTAssertNotEqual(request1, request2, "Requests with different HTTP methods should not be equal.")
    }

    
    /// Tests `NetworkRequest` with a large body of data.
    func testInitializationWithLargeBody() {
        // Arrange
        let path = "/upload"
        let method = HTTPMethod.post
        let body = Data(repeating: 0, count: 10_000) // Large body of 10,000 bytes
        
        // Act
        let request = NetworkRequest(path: path, method: method, body: body)
        
        // Assert
        XCTAssertEqual(request.body?.count, 10_000, "The body should match the large data size.")
    }
}
