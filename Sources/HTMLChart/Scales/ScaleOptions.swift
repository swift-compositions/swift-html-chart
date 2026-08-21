import Foundation

public struct ScaleOptions: Sendable {

    public let scales: [String: any Scale]

    public init(scales: [String: any Scale] = [:]) {
        self.scales = scales
    }

    public init(x: (any Scale)? = nil, y: (any Scale)? = nil) {
        var scales: [String: any Scale] = [:]
        if let x {
            scales["x"] = x
        }
        if let y {
            scales["y"] = y
        }
        self.scales = scales
    }

}

extension ScaleOptions {

    public func adding(_ scale: any Scale, withId id: String) -> Self {
        var newScales = scales
        newScales[id] = scale
        return Self(scales: newScales)
    }

    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]

        for (id, scale) in scales {
            dict[id] = scale.toDictionary()
        }

        return dict
    }
}

public struct ScaleBuilder {

    private var scales: [String: any Scale] = [:]

    public init() {}

}

extension ScaleBuilder {

    public func x(_ scale: any Scale) -> Self {
        var builder = self
        builder.scales["x"] = scale
        return builder
    }

    public func y(_ scale: any Scale) -> Self {
        var builder = self
        builder.scales["y"] = scale
        return builder
    }

    public func r(_ scale: any Scale) -> Self {
        var builder = self
        builder.scales["r"] = scale
        return builder
    }

    public func custom(_ id: String, scale: any Scale) -> Self {
        var builder = self
        builder.scales[id] = scale
        return builder
    }

    public func build() -> ScaleOptions {
        ScaleOptions(scales: scales)
    }
}
