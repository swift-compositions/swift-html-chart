import HTML
import Testing

@testable import HTMLChart

@Suite
struct `String escaping in generated JavaScript` {

    static let hostile = "It's </script><script>alert(1)</script>\n\u{2028}\\"

    static func chart() -> LineChart {
        LineChart(
            id: "escape-chart",
            data: ChartData(
                labels: [hostile, "plain"],
                dataset: LineDataset(label: hostile, data: [1, 2], borderColor: .blue)
            )
        )
    }

    @Test
    func `labels and dataset labels are emitted as escaped single-quoted literals`() throws {
        let js = ChartConfiguration(
            type: .line,
            data: ChartData(
                labels: [Self.hostile, "plain"],
                dataset: LineDataset(label: Self.hostile, data: [1, 2], borderColor: .blue)
            )
        ).toJavaScript()
        let escaped = #"'It\'s \u003C/script>\u003Cscript>alert(1)\u003C/script>\n\u2028\\'"#
        #expect(js.contains(escaped))
        #expect(!js.contains("</script>"))
        #expect(!js.contains("\n\u{2028}"))
        #expect(js.contains("'plain'"))
    }

    @Test
    func `a hostile label cannot close the script element`() throws {
        let html = try String(Self.chart())
        #expect(html.components(separatedBy: "</script>").count - 1 == html.components(separatedBy: "<script").count - 1)
        #expect(!html.contains("alert(1)</script>"))
    }
}
