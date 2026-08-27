// swift-tools-version: 6.4

import PackageDescription

extension String {
    static let htmlChart: Self = "HTMLChart"
}

extension Target.Dependency {
    static var htmlChart: Self { .target(name: .htmlChart) }
}

extension Target.Dependency {
    static var html: Self { .product(name: "HTML", package: "swift-html") }
}

let package = Package(
    name: "swift-html-chart",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .macCatalyst(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: .htmlChart,
            targets: [.htmlChart]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-compositions/swift-html.git", branch: "main")
    ],
    targets: [
        .target(
            name: .htmlChart,
            dependencies: [
                .html
            ]
        ),
        .testTarget(
            name: .htmlChart.tests,
            dependencies: [
                .htmlChart
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { "\(self) Tests" }
}
