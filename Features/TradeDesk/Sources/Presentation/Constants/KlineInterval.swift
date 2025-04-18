public enum KlineInterval: String, CaseIterable, Identifiable {
    case oneMinute = "1m"
    case fiveMinutes = "5m"
    case fifteenMinutes = "15m"
    case oneHour = "1h"
    case oneDay = "1d"

    public var id: String { rawValue }

    public var label: String {
        switch self {
        case .oneMinute: return "1m"
        case .fiveMinutes: return "5m"
        case .fifteenMinutes: return "15m"
        case .oneHour: return "1h"
        case .oneDay: return "1d"
        }
    }

    public var limit: Int {
        switch self {
        case .oneMinute: return 1440  // 24h of 1-min candles
        case .fiveMinutes: return 288
        case .fifteenMinutes: return 96
        case .oneHour: return 24
        case .oneDay: return 30
        }
    }
}
