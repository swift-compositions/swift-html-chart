// swift-tools-version: 6.3.3

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
        .macOS("27"),
        .iOS("27"),
        .tvOS("27"),
        .watchOS("27"),
        .macCatalyst(.v26),
        .visionOS("27")
    ],
    products: [
        .library(
            name: .htmlChart,
            targets: [.htmlChart]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-foundations/swift-html.git", branch: "main")
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
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String {
    var tests: Self { "\(self) Tests" }
}
