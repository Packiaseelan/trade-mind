import Foundation

class ConfigManager {
    static let shared = ConfigManager()
    
    private init() {}
    
    public var baseUrl: String {
        let httpProtocol = Bundle.main.infoDictionary?["BASE_URL_PROTOCOL"] as? String ?? ""
        let httpHost = Bundle.main.infoDictionary?["BASE_URL_HOST"] as? String ?? ""
        return "\(httpProtocol)://\(httpHost)/api/"
    }
}
