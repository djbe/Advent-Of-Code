//
// Advent
// Copyright © 2020 David Jennes
//

import ArgumentParser
import Foundation

public protocol Day {
	static var name: String { get }

	init(input: Input)

	mutating func part1() -> Any
	mutating func part2() -> Any
}

public extension Day {
	mutating func run() {
		let day = Int(String(describing: Self.self).dropFirst(3)) ?? 0
		assert(day != 0, "Could not parse day from class name: \(Self.self)")

		logDay(day, Self.name)

		print("Part 1 result: \(part1())")
		print("Part 2 result: \(part2())")

		print()
	}
}
