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
  targets: [
    .target(
      name: "SwiftlyUI",
      dependencies: []
    ),
    .testTarget(name: "SwiftlyUITests", dependencies: ["SwiftlyUI"]),
  ]
)
