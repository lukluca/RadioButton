// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "RadioButton",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v14),
        .watchOS(.v6),
        .tvOS(.v16),
    ],
    products: [
        .library(
            name: "RadioButton",
            targets: ["RadioButton"]),
    ],
    targets: [
        .target(
            name: "RadioButton"),
        .testTarget(
            name: "RadioButtonTests",
            dependencies: ["RadioButton"]),
    ]
)
