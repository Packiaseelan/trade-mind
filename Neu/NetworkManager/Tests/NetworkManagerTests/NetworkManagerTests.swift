import XCTest

import Core
import Foundation

@preconcurrency import Combine
@testable import NetworkManager

final class NetworkManagerTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        cancellables = []
        // Set up URLSession with mock URLProtocol
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession(configuration: configuration)
        networkManager = NetworkManager(baseURL: "https://example.com", urlSession: urlSession)
    }

    override func tearDown() {
        cancellables = nil
        networkManager = nil
        super.tearDown()
    }

    func testRequest_SuccessfulResponse() {
        // Arrange
        let expectedData = #"{"name":"Test"}"#.data(using: .utf8)!
        URLProtocolMock.mockResponse = (data: expectedData, response: HTTPURLResponse(url: URL(string: "https://example.com/test")!,
                                                                                      statusCode: 200,
                                                                                      httpVersion: nil,
                                                                                      headerFields: nil)!, error: nil)
        let requestModel = NetworkRequest(path: "/test", method: .get)

        // Act & Assert
        let expectation = XCTestExpectation(description: "Request should succeed")
        networkManager.request(with: requestModel)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Request failed unexpectedly")
                }
            }, receiveValue: { (response: TestResponse) in
                XCTAssertEqual(response.name, "Test")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequest_InvalidURL() {
        // Arrange
        let invalidBaseURL = ""
        networkManager = NetworkManager(baseURL: invalidBaseURL)
        let requestModel = NetworkRequest(path: "/test", method: .get)

        // Act & Assert
        let expectation = XCTestExpectation(description: "Request should fail with invalid URL error")
        networkManager.request(with: requestModel)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, NetworkError.invalidURL)
                    expectation.fulfill()
                }
            }, receiveValue: { (_: TestResponse) in
                XCTFail("Request succeeded unexpectedly")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequest_DecodingFailed() {
        // Arrange
        let invalidData = #"{"wrong_key":"Test"}"#.data(using: .utf8)!
        URLProtocolMock.mockResponse = (data: invalidData, response: HTTPURLResponse(url: URL(string: "https://example.com/test")!,
                                                                                      statusCode: 200,
                                                                                      httpVersion: nil,
                                                                                      headerFields: nil)!, error: nil)
        let requestModel = NetworkRequest(path: "/test", method: .get)

        // Act & Assert
        let expectation = XCTestExpectation(description: "Request should fail with decoding error")
        networkManager.request(with: requestModel)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, NetworkError.decodingFailed)
                    expectation.fulfill()
                }
            }, receiveValue: { (_: TestResponse) in
                XCTFail("Request succeeded unexpectedly")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testRequest_ServerError() {
        // Arrange
        URLProtocolMock.mockResponse = (data: nil, response: HTTPURLResponse(url: URL(string: "https://example.com/test")!,
                                                                              statusCode: 500,
                                                                              httpVersion: nil,
                                                                              headerFields: nil)!, error: nil)
        let requestModel = NetworkRequest(path: "/test", method: .get)

        // Act & Assert
        let expectation = XCTestExpectation(description: "Request should fail with server error")
        networkManager.request(with: requestModel)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, NetworkError.serverError(statusCode: 500))
                    expectation.fulfill()
                }
            }, receiveValue: { (_: TestResponse) in
                XCTFail("Request succeeded unexpectedly")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
