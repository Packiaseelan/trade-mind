// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NavigationManager",
    platforms: [.iOS(.v17)], // Minimum iOS version set to 17.0
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NavigationManager",
            targets: ["NavigationManager"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Core")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NavigationManager",
            dependencies: ["Core"]
        ),
        .testTarget(
            name: "NavigationManagerTests",
            dependencies: ["NavigationManager", "Core"]
        ),
    ]
)
