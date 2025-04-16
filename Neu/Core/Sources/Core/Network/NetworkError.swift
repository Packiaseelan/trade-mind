import Foundation

// Define NetworkError enum
public enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case decodingFailed
    case serverError(statusCode: Int)
    case unknownError

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .decodingFailed:
            return "Failed to decode the response."
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
