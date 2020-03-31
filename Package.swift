// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "TPKit",
    products: [
        .library(name: "TPKit", targets: ["TPKit"]),
    ],
    targets: [
        .target(
            name: "TPKit",
			path: "Pod/Sources")
    ]
)
