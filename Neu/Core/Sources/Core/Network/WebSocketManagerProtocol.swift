import Combine
import Foundation

public protocol WebSocketDecodable: Decodable {
    static func fromWebSocketString(_ string: String) -> Self?
}


public protocol WebSocketManagerProtocol: AnyObject {
    associatedtype T: Decodable
    var dataPublisher: AnyPublisher<T, Never> { get }
    func connect(with url: URL)
    func disconnect()
}
