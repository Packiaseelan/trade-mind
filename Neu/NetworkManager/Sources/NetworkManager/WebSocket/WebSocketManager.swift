import Foundation
import Combine
import Core
import Starscream

public final class WebSocketManager<T: WebSocketDecodable>: NSObject, WebSocketManagerProtocol {
        
    private let subject = PassthroughSubject<T, Never>()
    private var socket: WebSocket?
    
    public var dataPublisher: AnyPublisher<T, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public override init() {
        super.init()
    }
    
    public func connect(with url: URL) {
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        let socket = WebSocket(request: request)
        socket.delegate = self
        self.socket = socket
        socket.connect()
    }
    
    public func disconnect() {
        socket?.disconnect()
        socket = nil
    }
}

extension WebSocketManager: WebSocketDelegate {
    
    public func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        switch event {
        case .connected:
            print("WebSocket connected")
        case .disconnected(let reason, let code):
            print("WebSocket disconnected: \(reason) (\(code))")
        case .text(let string):
            handleString(string)
        case .error(let error):
            print("WebSocket error: \(String(describing: error))")
        default:
            break
        }
    }
    
    
    private func handleString(_ string: String) {
        guard let model = T.fromWebSocketString(string) else {
            print("Failed to decode \(T.self) from string.")
            return
        }
        
        subject.send(model)
    }
}
