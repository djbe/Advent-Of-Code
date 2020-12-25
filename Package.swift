// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "Advent",
	platforms: [
		.macOS(.v10_15)
	],
	products: [
		.executable(name: "advent", targets: ["Advent"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-algorithms", .branch("main")),
		.package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
		.package(url: "https://github.com/sharplet/Regex.git", from: "2.1.0"),
		// Tooling
		.package(url: "https://github.com/shibapm/Komondor", from: "1.0.0"),
		.package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.41.2"),
		.package(url: "https://github.com/realm/SwiftLint", from: "0.41.0")
	],
	targets: [
		.target(name: "Advent", dependencies: ["Advent 2019", "Advent 2020"]),
		.target(name: "Advent 2019", dependencies: ["Common"], resources: [.process("Input")]),
		.target(name: "Advent 2020", dependencies: ["Common"], resources: [.process("Input")]),
		.target(name: "Common", dependencies: [
			.product(name: "Algorithms", package: "swift-algorithms"),
			.product(name: "ArgumentParser", package: "swift-argument-parser"),
			.product(name: "Regex", package: "Regex")
		]),
		.testTarget(name: "AdventTests", dependencies: ["Advent 2019", "Advent 2020"], resources: [.copy("Input")])
	],
	swiftLanguageVersions: [.v5]
)

#if canImport(PackageConfig)
import PackageConfig

let config = PackageConfiguration([
	"komondor": [
		"pre-commit": [
			"swift run swiftformat .",
			"swift run swiftlint autocorrect --quiet"
		]
	]
]).write()
#endif
