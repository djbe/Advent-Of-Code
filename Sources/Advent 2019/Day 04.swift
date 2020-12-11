import Algorithms
import Common

struct Day04: Day {
	var name: String { "Secure Container" }

	private static let range = 382345...843167
}

// MARK: - Part 1

extension Day04 {
	func isValid(password: Int) -> Bool {
		let string = "\(password)"
		guard Self.range.contains(password) else { return false }
		guard zip(string, string.dropFirst()).allSatisfy({ $0 <= $1 }) else { return false }
		return zip(string, string.dropFirst()).contains { $0 == $1 }
	}

	mutating func part1() {
		logPart("How many different passwords within the range given in your puzzle input meet these criteria?")

		let result = Self.range.filter(isValid(password:)).count
		log(.info, "Number of valid passwords: \(result)")
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

	mutating func part2() {
		logPart("What is 100 * noun + verb?")

		let result = Self.range.filter(betterIsValid(password:))
		log(.info, "Number of valid passwords: \(result.count)")
	}
}
