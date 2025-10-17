// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftlyUI",
  platforms: [.macOS(.v14)],
  products: [
    .library(name: "SwiftlyUI", targets: ["SwiftlyUI"]),
    .library(name: "SwiftlyUICore", targets: ["SwiftlyUICore"]),
    .library(name: "GtkUI", targets: ["GtkUI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log", exact: "1.6.4"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump.git", revision: "c3671e8409552472a4c3b9e7205e72d32f8ded9f"),
  ],
  targets: [
    .target(
      name: "SwiftlyUI",
      dependencies: [
        .target(name: "GtkUI", condition: .when(platforms: [.linux, .windows]))
      ]
    ),
    .target(
      name: "SwiftlyUICore",
      dependencies: [
        .product(name: "Logging", package: "swift-log")
      ]
    ),
    .testTarget(
      name: "SwiftlyUICoreTests",
      dependencies: [
        "SwiftlyUICore",
        .product(name: "CustomDump", package: "swift-custom-dump"),
      ]
    ),
    .target(
      name: "GtkUI",
      dependencies: [
        "SwiftlyUICore",
        "CGTK",
      ]
    ),
    .systemLibrary(
      name: "CGTK",
      pkgConfig: "gtk4",
      providers: [
        .brew(["gtk4"]),
        .apt(["libgtk4"]),
      ]
    ),
  ]
)
