import Foundation

final class URLProtocolMock: URLProtocol {
    nonisolated(unsafe) static var mockResponse: (data: Data?, response: URLResponse?, error: Error?)?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let mockResponse = URLProtocolMock.mockResponse {
            if let data = mockResponse.data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = mockResponse.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = mockResponse.error {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                client?.urlProtocolDidFinishLoading(self)
            }
        }
    }

    override func stopLoading() {
        // No-op
    }
}
