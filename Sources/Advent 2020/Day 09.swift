//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day09: Day {
	static let name = "Encoding Error"
	private let numbers: [Int]
	private var invalidNumber = 0
	var preamble = 25

	init(input: Input) {
		numbers = input.lines.compactMap(\.integer)
	}
}

// MARK: - Part 1

extension Day09 {
	func check(sequence: [Int], history: Int) -> Int? {
		sequence.slidingWindows(ofCount: history + 1).first { numbers in
			let newNumber = numbers.last ?? 0
			return !Array(numbers.prefix(history)).permutations(ofCount: 2)
				.contains { $0.sum == newNumber }
		}?.last
	}

	mutating func part1() -> Any {
		logPart("What is the first number that does not have this property?")

		invalidNumber = check(sequence: numbers, history: preamble) ?? 0
		return invalidNumber
	}
}

// MARK: - Part 2

extension Day09 {
	func findWeakness(sequence: [Int], invalid: Int) -> [Int] {
		for size in 3... {
			if let result = sequence.slidingWindows(ofCount: size).first(where: { $0.sum == invalid }) {
				return Array(result)
			}
		}
		return []
	}

	mutating func part2() -> Any {
		logPart("What is the encryption weakness in your XMAS-encrypted list of numbers?")

		let result = findWeakness(sequence: numbers, invalid: invalidNumber)
		log(.info, "Found weakness: \(result)")

		return (result.min() ?? 0) + (result.max() ?? 0)
	}
}
