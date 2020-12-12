//
// Advent
// Copyright © 2020 David Jennes
//

import Common
import Foundation

struct Day01: Day {
	var name: String { "The Tyranny of the Rocket Equation" }

	private lazy var input = loadInputFile().compactMap { Int(String($0)) }
}

// MARK: - Part 1

extension Day01 {
	func fuelNeeded(for mass: Int) -> Int {
		max(Int(floor(Float(mass) / 3) - 2), 0)
	}

	mutating func part1() -> Any {
		logPart("What is the sum of the fuel requirements for all of the modules on your spacecraft?")

		return input.map(fuelNeeded(for:)).reduce(0, +)
	}
}

// MARK: - Part 2

extension Day01 {
	func accurateFuelNeeded(for mass: Int) -> Int {
		let fuel = fuelNeeded(for: mass)
		let extra = fuel > 0 ? accurateFuelNeeded(for: fuel) : 0
		return fuel + extra
	}

	mutating func part2() -> Any {
		logPart("What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into account the mass of the added fuel?")

		return input.map(accurateFuelNeeded(for:)).reduce(0, +)
	}
}
