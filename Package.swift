// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ExSejima",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "ExSejima",
            targets: ["ExSejima"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ExSejima",
            dependencies: [],
            path: "ExSejima/Source"
        )
    ]
)