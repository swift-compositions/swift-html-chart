import HTML
import Testing

@testable import HTMLChart

@Suite("HTML Generation Tests")
struct GenerationTests {

    @Test
    func `Generate simple line chart HTML`() throws {
        let chart = LineChart(
            id: "test-chart",
            data: ChartData(
                labels: ["Jan", "Feb", "Mar"],
                dataset: LineDataset(
                    label: "Test Data",
                    data: [10, 20, 15],
                    borderColor: .blue
                )
            )
        )

        let html = try String(chart)

        #expect(html.contains("<canvas"))
        #expect(html.contains("id=\"test-chart\""))

        #expect(html.contains("<script>"))
        #expect(html.contains("new Chart"))

        print("Generated HTML:")
        print(html)
    }

    @Test
    func `ChartConfiguration generates valid JavaScript`() {
        let config = ChartConfiguration(
            type: .line,
            data: ChartData(
                labels: ["A", "B", "C"],
                dataset: LineDataset(
                    label: "Test",
                    data: [1, 2, 3],
                    borderColor: .rgb(255, 0, 0)
                )
            )
        )

        let js = config.toJavaScript()

        #expect(js.contains("type: 'line'"))
        #expect(js.contains("labels: ['A', 'B', 'C']"))
        #expect(js.contains("datasets: ["))
        #expect(js.contains("label: 'Test'"))

        print("Generated JavaScript config:")
        print(js)
    }

    @Test
    func `ChartScript generates initialization code`() throws {
        let config = ChartConfiguration(
            type: .bar,
            data: ChartData(
                labels: ["Q1", "Q2"],
                dataset: BarDataset(
                    label: "Revenue",
                    data: [100, 150],
                    backgroundColor: .green
                )
            )
        )

        let script = ChartScript(
            chartId: "bar-chart",
            configuration: config
        )

        let html = try String(script)

        #expect(html.contains("init_bar-chart"))
        #expect(html.contains("getElementById('bar-chart')"))
        #expect(html.contains("new Chart"))

        print("Generated script:")
        print(html)
    }

    @Test
    func `Dataset dictionary conversion`() {
        let dataset = LineDataset(
            label: "Test",
            data: [1, 2, 3],
            borderColor: .rgb(255, 0, 0),
            tension: 0.4,
            fill: true
        )

        let dict = dataset.toDictionary()

        #expect(dict["label"] as? String == "Test")
        #expect(dict["borderColor"] as? String == "rgb(255, 0, 0)")
        #expect(dict["tension"] as? Double == 0.4)

        print("Dataset dictionary:")
        print(dict)
    }
}
