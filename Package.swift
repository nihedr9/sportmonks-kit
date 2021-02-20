// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "sportmonks-kit",
    products: [
        .library(
            name: "sportmonks-kit",
            targets: ["sportmonks-kit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.2.3"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "sportmonks-kit",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "Logging", package: "swift-log"),
            ]),
        .testTarget(
            name: "sportmonks-kitTests",
            dependencies: ["sportmonks-kit"]),
    ]
)
