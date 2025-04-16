// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TradeDesk",
    platforms: [.iOS(.v17)], // Minimum iOS version set to 17.0
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "TradeDesk", targets: ["TradeDesk"]),
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
            name: "TradeDesk",
            dependencies: ["Shared" ,"Core", "TradeDeskData", "TradeDeskDomain", "TradeDeskMapper", "TradeDeskPresentation"]
        ),
        
        .testTarget(
            name: "TradeDeskTests",
            dependencies: ["TradeDesk"]
        ),
        
        .target(name: "TradeDeskData",
                dependencies: ["Core", "NetworkManager"],
                path: "Sources/Data"
        ),
        
        .target(name: "TradeDeskDomain",
                dependencies: ["Shared", "TradeDeskData"],
                path: "Sources/Domain"
        ),
        
        .target(name: "TradeDeskMapper",
                dependencies: ["Core", "Shared", "TradeDeskData", "TradeDeskDomain"],
                path: "Sources/Mapper"
        ),
    
        .target(
            name: "TradeDeskPresentation",
            dependencies: ["Core", "TradeDeskDomain", "TradeDeskUiKit", "NavigationManager"],
            path: "Sources/Presentation"
        ),
        
        .target(
            name: "TradeDeskUiKit",
            dependencies: ["Shared" ,"Core"],
            path: "Sources/UiKit"
        ),
    ]
)
