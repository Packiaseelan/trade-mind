import Core
import Foundation

public enum CandleDataModelElement: Codable {
    case integer(Int)
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CandleDataModelElement.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CandleDataModelElement"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

public typealias CandleDataModel = [[CandleDataModelElement]]

extension Array: @retroactive BaseDataModel where Element == [CandleDataModelElement] {}
