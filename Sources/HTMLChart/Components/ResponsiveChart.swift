import Foundation
import HTML

public struct ResponsiveChart: HTML.View {
    public let chart: Chart
    public let aspectRatio: Double
    public let maxWidth: W3C_CSS_Values.Length?
    public let containerClass: HTML.Class.Attribute?

    public init(
        chart: Chart,
        aspectRatio: Double = 2.0,
        maxWidth: W3C_CSS_Values.Length? = nil,
        containerClass: HTML.Class.Attribute? = nil
    ) {
        self.chart = chart
        self.aspectRatio = aspectRatio
        self.maxWidth = maxWidth
        self.containerClass = containerClass
    }

    public init(
        id: String? = nil,
        configuration: ChartConfiguration,
        aspectRatio: Double = 2.0,
        maxWidth: W3C_CSS_Values.Length? = nil,
        containerClass: HTML.Class.Attribute? = nil
    ) {
        self.chart = Chart(
            id: id,
            configuration: configuration,
            responsive: true
        )
        self.aspectRatio = aspectRatio
        self.maxWidth = maxWidth
        self.containerClass = containerClass
    }
}

extension ResponsiveChart {
    public var body: some HTML.View {
        div {
            div {
                chart
            }
            .css
            .position(.absolute)
            .top(.zero)
            .left(.zero)
            .width(.percent(100))
            .height(.percent(100))
        }
        .css
        .position(.relative)
        .width(.percent(100))
        .inlineStyle("padding-bottom", "\(100.0 / aspectRatio)%")
        .if(let: maxWidth) { div, maxWidth in
            div.css.maxWidth(.length(maxWidth))
        }
        .if(let: containerClass) { div, containerClass in
            div.class(containerClass)
        }
    }
}
