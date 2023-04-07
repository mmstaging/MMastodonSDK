// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "MMastodon",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
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
