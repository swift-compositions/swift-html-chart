import Foundation

public struct ChartColor: Sendable, Codable, ExpressibleByStringLiteral {
    public let value: String

    public init(_ value: String) {
        self.value = value
    }

    public init(stringLiteral value: String) {
        self.value = value
    }
}

extension ChartColor {

    public static func rgb(_ red: Int, _ green: Int, _ blue: Int) -> Self {
        Self("rgb(\(red), \(green), \(blue))")
    }

    public static func rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Double) -> Self {
        Self("rgba(\(red), \(green), \(blue), \(alpha))")
    }

    public static func hex(_ hex: String) -> Self {
        Self(hex.hasPrefix("#") ? hex : "#\(hex)")
    }

    public static func hsl(_ hue: Int, _ saturation: Int, _ lightness: Int) -> Self {
        Self("hsl(\(hue), \(saturation)%, \(lightness)%)")
    }

    public static func hsla(
        _ hue: Int,
        _ saturation: Int,
        _ lightness: Int,
        _ alpha: Double
    )
        -> Self
    {
        Self("hsla(\(hue), \(saturation)%, \(lightness)%, \(alpha))")
    }

    public func withAlpha(_ alpha: Double) -> Self {

        Self("\(value)")
    }
}

extension ChartColor {
    public static let red = ChartColor("rgb(255, 99, 132)")
    public static let orange = ChartColor("rgb(255, 159, 64)")
    public static let yellow = ChartColor("rgb(255, 205, 86)")
    public static let green = ChartColor("rgb(75, 192, 192)")
    public static let blue = ChartColor("rgb(54, 162, 235)")
    public static let purple = ChartColor("rgb(153, 102, 255)")
    public static let grey = ChartColor("rgb(201, 203, 207)")

    public static let transparent = ChartColor("transparent")
    public static let white = ChartColor("white")
    public static let black = ChartColor("black")
}

public struct ChartGradient: Sendable {
    public let direction: Direction
    public let colors: [ColorStop]

    public init(direction: Direction, colors: [ColorStop]) {
        self.direction = direction
        self.colors = colors
    }

    public init(from: ChartColor, to: ChartColor, direction: Direction = .vertical) {
        self.direction = direction
        self.colors = [
            ColorStop(offset: 0, color: from),
            ColorStop(offset: 1, color: to),
        ]
    }
}

extension ChartGradient {
    public enum Direction: Sendable {
        case vertical
        case horizontal
        case diagonal
        case radial
    }

    public struct ColorStop: Sendable {
        public let offset: Double
        public let color: ChartColor

        public init(offset: Double, color: ChartColor) {
            self.offset = offset
            self.color = color
        }
    }
}
