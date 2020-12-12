//
// Advent
// Copyright © 2020 David Jennes
//

import ArgumentParser
import Foundation

public protocol Day: ParsableCommand {
	var name: String { get }

	mutating func part1()
	mutating func part2()
}

public extension Day {
	mutating func run() {
		let day = Int(String(describing: Self.self).dropFirst(3)) ?? 0
		assert(day != 0, "Could not parse day from class name: \(Self.self)")

		logDay(day, name)

		part1()
		part2()

		print()
	}
}
