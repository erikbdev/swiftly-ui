// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftlyUI",
  platforms: [.macOS(.v14)],
  products: [
    .library(
      name: "SwiftlyUI",
      targets: ["SwiftlyUI"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log", exact: "1.6.4"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump.git", revision: "c3671e8409552472a4c3b9e7205e72d32f8ded9f"),
  ],
  targets: [
    .target(
      name: "SwiftlyUI",
      dependencies: [
        .product(name: "Logging", package: "swift-log")
      ]
    ),
    .testTarget(
      name: "SwiftlyUITests",
      dependencies: [
        "SwiftlyUI",
        .product(name: "CustomDump", package: "swift-custom-dump"),
      ]
    ),
  ]
)
