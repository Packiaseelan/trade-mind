/// A class that provides static identifiers for different modules within an application.
/// These identifiers are used to uniquely identify modules, facilitating module registration,
/// navigation, and configuration in a modular application architecture.
public class ModuleIdentifier {
    // Global module
    public static let global = "global"
    
    // Core modules
    public static let network = "Network"
    public static let navigation = "Navigation"
    
    // Feature modules
    public static let authentication = "authentication"
    public static let marketData = "marketData"
    public static let aiAnalyzer = "aiAnalyzer"
    public static let tradingEngine = "tradingEngine"
    public static let tradeHistory = "tradeHistory"
    public static let notifications = "notifications"
    public static let settings = "settings"
    public static let tradeDesk = "tradeDesk"
    public static let backendSync = "backendSync"
}



public class AuthenticationModuleIdentifier {
    public enum Screen: Hashable {
        case login
    }
    
    public enum Mapper {
        public static let login = "login"
    }
}

public class TradeDeskModuleIdentifier {
    public enum Screen: Hashable {
        case landing
        case assetDetails
    }
    
    public enum Mapper {
        public static let marketData = "marketData"
    }
}
