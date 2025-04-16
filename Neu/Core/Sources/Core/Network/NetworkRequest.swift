import Foundation

/// A structure representing an HTTP network request.
///
/// `NetworkRequest` encapsulates the details of an HTTP request, including the path, method, headers, body, and optional query parameters.
/// This structure can be used to model requests for making network calls.

public struct NetworkRequest: Equatable {
    
    /// The path or endpoint for the request.
    ///
    /// This represents the URL path to which the request will be made, for example: `/users` or `/products/{id}`.
    public let path: String
    
    /// The HTTP method for the request.
    ///
    /// This defines the type of request being made (e.g., `GET`, `POST`, `PUT`, `DELETE`).
    public let method: HTTPMethod
    
    /// The headers to be included in the request.
    ///
    /// This is an optional dictionary where keys are header names (e.g., `"Content-Type"`) and values are the corresponding header values (e.g., `"application/json"`).
    /// Can be `nil` if no headers are needed for the request.
    public let headers: [String: String]?
    
    /// The body of the request.
    ///
    /// This is an optional `Data` object that contains the request body (e.g., for `POST` or `PUT` requests).
    /// Can be `nil` if the request does not contain a body (e.g., `GET` requests).
    public let body: Data?
    
    /// The query parameters for the request.
    ///
    /// This is an optional dictionary where keys are query parameter names and values are the corresponding values.
    /// For example: `["search": "test", "page": "1"]`.
    /// Can be `nil` if no query parameters are needed.
    public let queryParameters: [String: String]?
    
    /// Initializes a new `NetworkRequest` with the provided parameters.
    ///
    /// - Parameters:
    ///   - path: The path or endpoint for the request.
    ///   - method: The HTTP method for the request (e.g., `GET`, `POST`).
    ///   - headers: An optional dictionary of headers to include in the request.
    ///   - body: An optional body of type `Data` to include in the request.
    ///   - queryParameters: An optional dictionary of query parameters for the request.
    public init(path: String, method: HTTPMethod, headers: [String: String]? = nil, body: Data? = nil, queryParameters: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
        self.queryParameters = queryParameters
    }
}
