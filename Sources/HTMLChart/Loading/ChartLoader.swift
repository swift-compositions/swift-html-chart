import Foundation
import HTML

public protocol ChartLoader: HTML.View {
    var loadingStrategy: ChartLoadingStrategy { get }
}

public enum ChartLoadingStrategy: Sendable {
    case cdn(version: String, minified: Bool = true)
    case npm(path: String)
    case esm(url: String)
    case custom(url: String)
}
