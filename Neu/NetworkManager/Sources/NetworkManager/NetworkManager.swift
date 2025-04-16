import Foundation
import Core
import Combine

/// A class responsible for managing network requests with injectable dependencies for testing.
public class NetworkManager: NetworkManagerProtocol {
    /// The base URL for the network requests.
    private let baseURL: String
    /// The URLSession instance used to perform network requests.
    private let urlSession: URLSession

    /// Initializes a new instance of `NetworkManager`.
    /// - Parameter baseURL: The base URL to be used for all network requests.
    /// - Parameter urlSession: The `URLSession` instance for network calls (default is `SecureURLSession.shared`).
    public init(baseURL: String, urlSession: URLSession = SecureURLSession.shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    /// Makes a network request and returns a publisher that emits a decoded object of type `T`.
    /// - Parameter model: The network request model containing the request details.
    /// - Returns: A publisher that emits a decoded object of type `T` or a `NetworkError`.
    public func request<T: Decodable>(with model: NetworkRequest) -> AnyPublisher<T, NetworkError> {
        // Construct URL components from the base URL and the request path.
        guard !baseURL.isEmpty,
              var urlComponents = URLComponents(string: baseURL + model.path) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        // Add query parameters to the URL if they exist.
        if let queryParameters = model.queryParameters {
            urlComponents.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        // Create a URL from the URL components.
        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        // Create a URL request with the specified method, body, and headers.
        var request = URLRequest(url: url)
        request.httpMethod = model.method.rawValue
        request.httpBody = model.body
        model.headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        // Use a data task publisher to perform the network request.
        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response -> T in
                // Ensure the response is an HTTP response and check the status code.
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.unknownError
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
                }

                // Attempt to decode the data into the specified type `T`.
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw NetworkError.decodingFailed
                }
            }
            .mapError {
                // Map any error to a `NetworkError`.
                return $0 as? NetworkError ?? .unknownError
            }
            .eraseToAnyPublisher()
    }
}
