//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

struct Day25: Day {
	static let name = "Combo Breaker"
	private let cardKey: Int
	private let doorKey: Int

	init(input: Input) {
		let numbers = input.lines.compactMap(\.integer)
		cardKey = numbers[0]
		doorKey = numbers[1]
	}
}

// MARK: - Part 1

extension Day25 {
	private static let remainder = 20_201_227

	private func loopSize(key: Int, subject: Int = 7) -> Int {
		var value = 1
		for loop in 1... {
			value = (value * subject) % Self.remainder
			if value == key {
				return loop
			}
		}
		return 0
	}

	private func apply(subject: Int, loops: Int) -> Int {
		(1...loops).reduce(1) { value, _ in (value * subject) % Self.remainder }
	}

	mutating func part1() -> Any {
		logPart("What encryption key is the handshake trying to establish?")

		let cardLoops = loopSize(key: cardKey)

		return apply(subject: doorKey, loops: cardLoops)
	}
}

// MARK: - Part 2

extension Day25 {
	mutating func part2() -> Any {
		logPart("Looks like you only needed 49 stars after all.")

		return 0
	}
}
