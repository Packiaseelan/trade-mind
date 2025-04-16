import Foundation

/// A custom `URLSessionDelegate` that allows connections to self-signed SSL certificates.
///
/// This delegate overrides the authentication challenge handling to automatically trust self-signed certificates.
/// Use this delegate with `URLSession` when working with development or testing environments that require
/// bypassing SSL verification.
///
final class SelfSignedURLSessionDelegate: NSObject, URLSessionDelegate {
    
    /// Handles server authentication challenges and allows self-signed certificates.
    ///
    /// - Parameters:
    ///   - session: The `URLSession` instance that received the challenge.
    ///   - challenge: The authentication challenge received from the server.
    ///   - completionHandler: A closure that must be called with the appropriate disposition and credentials.
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Check if the authentication method is based on server trust (i.e., SSL/TLS certificate validation)
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
           
           // Retrieve the server's trust object (certificate validation information)
           let serverTrust = challenge.protectionSpace.serverTrust {
            
            // Create a URLCredential using the provided server trust, effectively trusting the certificate
            let credential = URLCredential(trust: serverTrust)
            
            // Call the completion handler with `.useCredential` to accept the self-signed certificate
            completionHandler(.useCredential, credential)
        } else {
            // If the authentication method is not based on server trust, perform default handling
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
