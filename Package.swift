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
    .package(url: "https://github.com/apple/swift-log", exact: "1.6.4")
  ],
  targets: [
    .target(
      name: "SwiftlyUI",
      dependencies: [
        .product(name: "Logging", package: "swift-log")
      ]
    ),
    .testTarget(name: "SwiftlyUITests", dependencies: ["SwiftlyUI"]),
  ]
)
