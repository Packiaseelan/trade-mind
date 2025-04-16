// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.iOS(.v17)], // Minimum iOS version set to 17.0
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Authentication", targets: ["Authentication"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Neu/Core"),
        .package(path: "../Neu/NetworkManager"),
        .package(path: "../Neu/NavigationManager"),
        .package(path: "../Shared")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Authentication",
            dependencies: ["Shared" ,"Core", "AuthenticationMapper", "AuthenticationData", "AuthenticationDomain", "AuthenticationPresentation"]
        ),
        
        .testTarget(
            name: "AuthenticationTests",
            dependencies: ["Authentication"]
        ),
                
        .target(name: "AuthenticationData",
                dependencies: ["Core", "NetworkManager"],
                path: "Sources/Data"
        ),
        
        .target(name: "AuthenticationDomain",
                dependencies: ["Shared", "AuthenticationData"],
                path: "Sources/Domain"
        ),
        
        .target(name: "AuthenticationMapper",
                dependencies: ["Core", "Shared", "AuthenticationData", "AuthenticationDomain"],
                path: "Sources/Mapper"
        ),
    
        .target(
            name: "AuthenticationPresentation",
            dependencies: ["Core", "AuthenticationDomain", "AuthenticationUiKit", "NavigationManager"],
            path: "Sources/Presentation"
        ),
        
        .target(
            name: "AuthenticationUiKit",
            dependencies: ["Shared" ,"Core"],
            path: "Sources/UiKit"
        ),
    ]
)
