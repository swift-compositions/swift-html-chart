import Foundation

public struct ChartPoint: Sendable, Codable {
    public let x: ChartValue
    public let y: ChartValue
    public let r: Double?

    public init(x: ChartValue, y: ChartValue, r: Double? = nil) {
        self.x = x
        self.y = y
        self.r = r
    }

    public init(x: Double, y: Double, r: Double? = nil) {
        self.x = .number(x)
        self.y = .number(y)
        self.r = r
    }

    public init(date: Date, value: Double, r: Double? = nil) {
        self.x = .date(date)
        self.y = .number(value)
        self.r = r
    }

    public init(category: String, value: Double, r: Double? = nil) {
        self.x = .string(category)
        self.y = .number(value)
        self.r = r
    }
}

public enum ChartValue: Sendable, Codable {
    case number(Double)
    case string(String)
    case date(Date)
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self = .null
            return
        }

        do {
            self = .number(try container.decode(Double.self))
            return
        } catch {}

        do {
            self = .string(try container.decode(String.self))
            return
        } catch {}

        do {
            self = .date(try container.decode(Date.self))
            return
        } catch {}

        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Cannot decode ChartValue"
        )
    }
}

extension ChartValue {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .number(let value):
            try container.encode(value)

        case .string(let value):
            try container.encode(value)

        case .date(let value):

            let formatter = ISO8601DateFormatter()
            try container.encode(formatter.string(from: value))

        case .null:
            try container.encodeNil()
        }
    }

    public var jsValue: String {
        switch self {
        case .number(let value):
            return String(value)

        case .string(let value):
            return "'\(value)'"

        case .date(let value):
            let formatter = ISO8601DateFormatter()
            return "'\(formatter.string(from: value))'"

        case .null:
            return "null"
        }
    }
}

extension ChartValue: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .number(Double(value))
    }
}

extension ChartValue: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .number(value)
    }
}

extension ChartValue: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}

extension ChartValue: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .null
    }
}
