// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "App",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // .library(name: "Feature", targets: ["Feature"]),
    ],
    dependencies: [
        // .package(url: "https://github.com/...", from: "1.0.0"),
    ],
    targets: [
        // .target(name: "Feature", dependencies: []),
        // .testTarget(name: "FeatureTests", dependencies: ["Feature"]),
    ]
)
