// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FabulaItemsProvider",
    platforms: [
        .iOS(.v15),
        .macOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FabulaItemsProvider",
            targets: ["FabulaItemsProvider"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.4.4"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", .branch("master")),
        .package(url: "https://github.com/jasudev/UnsplashProvider.git", .branch("main")),
        .package(url: "https://github.com/jasudev/Scroller.git", .branch("main")),
        .package(url: "https://github.com/jasudev/AnimateText.git", .branch("main")),
        .package(url: "https://github.com/jasudev/LottieUI.git", .branch("main")),
        .package(url: "https://github.com/jasudev/AxisSheet.git", .branch("main")),
        .package(url: "https://github.com/jasudev/AxisRatingBar.git", .branch("main")),
        .package(url: "https://github.com/jasudev/AxisContribution.git", .branch("main")),
        .package(url: "https://github.com/jasudev/AxisTooltip.git", .branch("main")),
        .package(url: "https://github.com/jasudev/AxisTabView.git", .branch("main")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "FabulaItemsProvider",
            dependencies: ["Alamofire",
                           "SDWebImageSwiftUI",
                           "UnsplashProvider",
                           "Scroller",
                           "AnimateText",
                           "LottieUI",
                           "AxisSheet",
                           "AxisRatingBar",
                           "AxisContribution",
                           "AxisTooltip",
                           "AxisTabView"]),
        .testTarget(
            name: "FabulaItemsProviderTests",
            dependencies: ["FabulaItemsProvider"]),
    ]
)
