//
// Advent
// Copyright © 2020 David Jennes
//

import Common
import Foundation

struct Day01: Day {
	static let name = "Report Repair"
	private let numbers: [Int]

	init(input: Input) {
		numbers = input.lines.compactMap(\.integer)
	}
}

// MARK: - Part 1

extension Day01 {
	func findMatchingTo2020(numbers: [Int], count: Int) -> [Int] {
		numbers.combinations(ofCount: count).first {
			$0.sum == 2_020
		} ?? []
	}

	mutating func part1() -> Any {
		logPart("Find the two entries that sum to 2020; what do you get if you multiply them together?")

		let matching = findMatchingTo2020(numbers: numbers, count: 2)
		return matching.product
	}
}

// MARK: - Part 2

extension Day01 {
	mutating func part2() -> Any {
		logPart("What is the product of the three entries that sum to 2020?")

		let matching = findMatchingTo2020(numbers: numbers, count: 3)
		return matching.product
	}
}
