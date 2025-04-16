import Combine
import Foundation

/// A protocol that defines the requirements for a network manager.
public protocol NetworkManagerProtocol {
    /// Makes a network request and returns a publisher that emits a decoded object of type `T`.
    /// - Parameter model: The network request model containing the request details.
    /// - Returns: A publisher that emits a decoded object of type `T` or a `NetworkError`.
    func request<T: Decodable>(with model: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
