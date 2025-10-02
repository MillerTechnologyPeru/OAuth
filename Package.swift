// swift-tools-version: 6.0
import PackageDescription
import class Foundation.ProcessInfo

// get environment variables
let environment = ProcessInfo.processInfo.environment
let dynamicLibrary = environment["SWIFT_BUILD_DYNAMIC_LIBRARY"] == "1"

// force building as dynamic library
var libraryType: PackageDescription.Product.Library.LibraryType? = dynamicLibrary ? .dynamic : nil

let package = Package(
    name: "OAuth",
    platforms: [
        .macOS(.v13),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "OAuth",
            type: libraryType,
            targets: ["OAuth"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/HTTP.git",
            branch: "master"
        )
    ],
    targets: [
        .target(
            name: "OAuth",
            dependencies: [
                .product(
                    name: "HTTP",
                    package: "HTTP"
                )
            ]
        ),
        .testTarget(
            name: "OAuthTests",
            dependencies: ["OAuth"]
        ),
    ]
)
