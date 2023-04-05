// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "MMastodon",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "MMastodon",
            targets: ["MMastodon"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "MMastodon",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]),
        .testTarget(
            name: "MMastodonTests",
            dependencies: ["MMastodon"]),
    ]
)
