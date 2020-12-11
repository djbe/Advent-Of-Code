// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Advent",
  products: [
    .executable(name: "advent-2019", targets: ["Advent 2019"]),
    .executable(name: "advent-2020", targets: ["Advent 2020"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-algorithms.git", .branch("main")),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0")
  ],
  targets: [
	.target(name: "Advent 2019", dependencies: ["Common"], resources: [.process("Input")]),
    .target(name: "Advent 2020", dependencies: ["Common"], resources: [.process("Input")]),
    .target(name: "Common", dependencies: [
      .product(name: "Algorithms", package: "swift-algorithms"),
      .product(name: "ArgumentParser", package: "swift-argument-parser")
    ])
  ],
  swiftLanguageVersions: [.v5]
)

#if canImport(PackageConfig)
import PackageConfig

let config = PackageConfiguration([
"komondor": [
    "pre-commit": [
    ]
  ]
]).write()
#endif
