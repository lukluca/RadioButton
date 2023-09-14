// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "RadioButton",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v14),
        .watchOS(.v7),
        .tvOS(.v14),
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
