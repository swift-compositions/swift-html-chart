// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-html-chart",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "HTMLChart",
            targets: ["HTMLChart"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-compositions/swift-html.git", branch: "main")
    ],
    targets: [
        .target(
            name: "HTMLChart",
            dependencies: [
                .product(name: "HTML", package: "swift-html")
            ]
        ),
        .testTarget(
            name: "HTMLChart Tests",
            dependencies: [
                .target(name: "HTMLChart")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

