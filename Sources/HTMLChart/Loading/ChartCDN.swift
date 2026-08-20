import Foundation
import HTML

/// CDN-based Chart.js loader
public struct ChartCDN: ChartLoader {
    public let version: String
    public let minified: Bool
    public let integrity: HTML.Integrity.Attribute?
    public let crossorigin: HTML.Crossorigin.Attribute?
    public let `defer`: HTML.Defer.Attribute
    public let async: HTML.Async.Attribute
    public let includePlugins: [CDNPlugin]

    public init(
        version: String = "4.4.0",
        minified: Bool = true,
        integrity: HTML.Integrity.Attribute? = nil,
        crossorigin: HTML.Crossorigin.Attribute? = "anonymous",
        defer: HTML.Defer.Attribute = true,
        async: HTML.Async.Attribute = false,
        includePlugins: [CDNPlugin] = []
    ) {
        self.version = version
        self.minified = minified
        self.integrity = integrity
        self.crossorigin = crossorigin
        self.defer = `defer`
        self.async = async
        self.includePlugins = includePlugins
    }
}

extension ChartCDN {
    public var loadingStrategy: ChartLoadingStrategy {
        .cdn(version: version, minified: minified)
    }

    public var body: some HTML.View {
        HTML.Group {
            // Main Chart.js library
            script(
                src: chartJsUrl,
                async: async,
                defer: `defer`,
                integrity: integrity,
                referrerpolicy: .noReferrer,
                crossorigin: crossorigin
            )

            // Additional plugins
            for plugin in includePlugins {
                script(
                    src: plugin.cdnUrl(version: version),
                    async: async,
                    defer: `defer`,
                    crossorigin: crossorigin
                )
            }
        }
    }

    private var chartJsUrl: HTML.Src.Attribute {
        let filename = minified ? "chart.umd.min.js" : "chart.umd.js"
        return .init("https://cdn.jsdelivr.net/npm/chart.js@\(version)/dist/\(filename)")
    }
}

/// Available Chart.js plugins from CDN
public enum CDNPlugin: String, Sendable {
    case datalabels = "chartjs-plugin-datalabels"
    case zoom = "chartjs-plugin-zoom"
    case annotation = "chartjs-plugin-annotation"
    case deferred = "chartjs-plugin-deferred"
    case streaming = "chartjs-plugin-streaming"
}

extension CDNPlugin {
    func cdnUrl(version: String) -> HTML.Src.Attribute {
        switch self {
        case .datalabels:
            return .init(
                "https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2/dist/chartjs-plugin-datalabels.min.js"
            )

        case .zoom:
            return .init(
                "https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom@2/dist/chartjs-plugin-zoom.min.js"
            )

        case .annotation:
            return .init(
                "https://cdn.jsdelivr.net/npm/chartjs-plugin-annotation@3/dist/chartjs-plugin-annotation.min.js"
            )

        case .deferred:
            return .init(
                "https://cdn.jsdelivr.net/npm/chartjs-plugin-deferred@2/dist/chartjs-plugin-deferred.min.js"
            )

        case .streaming:
            return .init(
                "https://cdn.jsdelivr.net/npm/chartjs-plugin-streaming@2/dist/chartjs-plugin-streaming.min.js"
            )
        }
    }
}
