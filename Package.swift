// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "LiquidLoader",
    platforms: [.iOS(.v8)],
    products: [.library(name: "LiquidLoader", targets: ["LiquidLoader"])],
    targets: [.target(name: "LiquidLoader", path: "Pod/Classes")]
)
