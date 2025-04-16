import Foundation

/// A singleton class that provides a secure `URLSession` instance with a custom delegate for handling self-signed certificates.
public class SecureURLSession {
    
    /// A shared instance of `URLSession` configured with a custom delegate to handle self-signed SSL certificates.
    /// - The session is configured with the default `URLSessionConfiguration`.
    /// - Uses `SelfSignedURLSessionDelegate` to handle authentication challenges.
    /// - Runs on the main operation queue.
    public static let shared: URLSession = {
        let configuration = URLSessionConfiguration.default
        let delegate = SelfSignedURLSessionDelegate()
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: OperationQueue.main)
    }()
}
