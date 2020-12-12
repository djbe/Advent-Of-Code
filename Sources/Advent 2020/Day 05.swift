//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private struct BoardingPass {
	private let row: Int
	private let column: Int

	init<T: StringProtocol>(_ data: T) {
		let data = data
			.replacingCharacters(from: CharacterSet(charactersIn: "LF"), with: "0")
			.replacingCharacters(from: CharacterSet(charactersIn: "BR"), with: "1")

		row = Int(data.prefix(7), radix: 2) ?? 0
		column = Int(data.suffix(3), radix: 2) ?? 0
	}

	var boardingPassID: Int {
		row * 8 + column
	}
}

struct Day05: Day {
	var name: String { "Binary Boarding" }

	private lazy var passes = loadInputFile().map(BoardingPass.init)
}

// MARK: - Part 1

extension Day05 {
	mutating func part1() -> Any {
		logPart("What is the highest seat ID on a boarding pass?")

		return passes.map(\.boardingPassID).max() ?? 0
	}
}

// MARK: - Part 2

extension Day05 {
	mutating func part2() -> Any {
		logPart("What is the ID of your seat?")

		let existing = Set(passes.map(\.boardingPassID))
		let range = (existing.min() ?? 0)...(existing.max() ?? 0)
		let available = Set(range)

		return available.subtracting(existing).first ?? 0
	}
}
