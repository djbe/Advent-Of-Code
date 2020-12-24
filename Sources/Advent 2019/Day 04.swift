//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day04: Day {
	static let name = "Secure Container"
	private let range: ClosedRange<Int>

	init(input: Input) {
		let numbers = input.words(separatedBy: "-").compactMap(\.integer)
		range = numbers[0]...numbers[1]
	}
}

// MARK: - Part 1

extension Day04 {
	func isValid(password: Int) -> Bool {
		let string = "\(password)"
		guard range.contains(password) else { return false }
		guard zip(string, string.dropFirst()).allSatisfy({ $0 <= $1 }) else { return false }
		return zip(string, string.dropFirst()).contains { $0 == $1 }
	}

	mutating func part1() -> Any {
		logPart("How many different passwords within the range given in your puzzle input meet these criteria?")

		return range.filter(isValid(password:)).count
	}
}

// MARK: - Part 2

extension Day04 {
	func betterIsValid(password: Int) -> Bool {
		guard isValid(password: password) else { return false }

		let string = "\(password)"
		return zip(0..., string.dropLast()).contains { (idx: Int, char: Character) -> Bool in
			char == string[idx + 1] && string[safe: idx - 1] != char && string[safe: idx + 2] != char
		}
	}

	mutating func part2() -> Any {
		logPart("How many different passwords within the range given in your puzzle input meet all of the criteria?")

		return range.filter(betterIsValid(password:)).count
	}
}
