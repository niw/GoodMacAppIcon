// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoodMacAppIcon",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "GoodMacAppIconCore",
            targets: [
                "GoodMacAppIconCore"
            ]
        ),
    ],
    targets: [
        .target(
            name: "GoodMacAppIconCore"
        ),
    ]
)
