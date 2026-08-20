import Foundation
import HTML

/// NPM/self-hosted Chart.js loader
public struct ChartNPM: ChartLoader {
    public let path: String
    public let `defer`: HTML.Defer.Attribute
    public let async: HTML.Async.Attribute
    public let type: HTML.Script.`Type`.Attribute?

    public init(
        path: String,
        defer: HTML.Defer.Attribute = true,
        async: HTML.Async.Attribute = false,
        type: HTML.Script.`Type`.Attribute? = nil
    ) {
        self.path = path
        self.defer = `defer`
        self.async = async
        self.type = type
    }
}

extension ChartNPM {
    public var loadingStrategy: ChartLoadingStrategy {
        .npm(path: path)
    }

    public var body: some HTML.View {
        script(
            src: .init(path),
            async: async,
            defer: `defer`,
            type: type
        )
    }
}

/// ES Module loader for Chart.js
public struct ChartESM: ChartLoader {
    public let url: String
    public let integrity: HTML.Integrity.Attribute?
    public let crossorigin: HTML.Crossorigin.Attribute?

    public init(
        url: String = "https://cdn.jsdelivr.net/npm/chart.js@4/+esm",
        integrity: HTML.Integrity.Attribute? = nil,
        crossorigin: HTML.Crossorigin.Attribute? = "anonymous"
    ) {
        self.url = url
        self.integrity = integrity
        self.crossorigin = crossorigin
    }
}

extension ChartESM {
    public var loadingStrategy: ChartLoadingStrategy {
        .esm(url: url)
    }

    public var body: some HTML.View {
        script(type: .module) {
            """
            import Chart from '\(url)';
            window.Chart = Chart;
            """
        }
    }
}
