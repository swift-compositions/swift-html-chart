import Foundation

public struct ChartData: Sendable, Codable {
    public let labels: [String]?

    public let datasets: [any ChartDataset]

    public init(labels: [String]? = nil, datasets: [any ChartDataset]) {
        self.labels = labels
        self.datasets = datasets
    }

    public init(labels: [String]? = nil, dataset: any ChartDataset) {
        self.labels = labels
        self.datasets = [dataset]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.labels = try container.decodeIfPresent([String].self, forKey: .labels)

        self.datasets = []
    }
}

extension ChartData {
    private enum CodingKeys: String, CodingKey {
        case labels
        case datasets
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(labels, forKey: .labels)

        var datasetsArray = [[String: Any]]()
        for dataset in datasets {
            datasetsArray.append(dataset.toDictionary())
        }

    }
}

public protocol ChartDataset: Sendable {
    var label: String { get }
    var data: [ChartValue] { get }
    var backgroundColor: ChartColor? { get }
    var borderColor: ChartColor? { get }
    var borderWidth: Double? { get }
    var hidden: Bool { get }
    var order: Int? { get }

    func toDictionary() -> [String: Any]
}

extension ChartDataset {
    public var hidden: Bool { false }
    public var order: Int? { nil }

    public func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "label": label,
            "data": data.map { $0.jsValue },
            "hidden": hidden,
        ]

        if let backgroundColor {
            dict["backgroundColor"] = backgroundColor.value
        }
        if let borderColor {
            dict["borderColor"] = borderColor.value
        }
        if let borderWidth {
            dict["borderWidth"] = borderWidth
        }
        if let order {
            dict["order"] = order
        }

        return dict
    }
}

public struct BaseDataset: ChartDataset {
    public let label: String
    public let data: [ChartValue]
    public let backgroundColor: ChartColor?
    public let borderColor: ChartColor?
    public let borderWidth: Double?
    public let hidden: Bool
    public let order: Int?

    public init(
        label: String,
        data: [ChartValue],
        backgroundColor: ChartColor? = nil,
        borderColor: ChartColor? = nil,
        borderWidth: Double? = nil,
        hidden: Bool = false,
        order: Int? = nil
    ) {
        self.label = label
        self.data = data
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.hidden = hidden
        self.order = order
    }

    public init(
        label: String,
        data: [Double],
        backgroundColor: ChartColor? = nil,
        borderColor: ChartColor? = nil,
        borderWidth: Double? = nil,
        hidden: Bool = false,
        order: Int? = nil
    ) {
        self.init(
            label: label,
            data: data.map { .number($0) },
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            borderWidth: borderWidth,
            hidden: hidden,
            order: order
        )
    }
}
