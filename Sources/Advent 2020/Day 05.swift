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

	var id: Int {
		row * 8 + column
	}
}

struct Day05: Day {
	var name: String { "Binary Boarding" }

	private lazy var passes = loadInputFile().map(BoardingPass.init)
}

// MARK: - Part 1

extension Day05 {
	mutating func part1() {
		logPart("What is the highest seat ID on a boarding pass?")

		log(.info, "Highest ID: \(passes.map(\.id).max() ?? 0)")
	}
}

// MARK: - Part 2

extension Day05 {
	mutating func part2() {
		logPart("What is the ID of your seat?")

		let existing = Set(passes.map(\.id))
		let range = (existing.min() ?? 0)...(existing.max() ?? 0)
		let available = Set(range.map { $0 })

		let openSeat = available.subtracting(existing).first ?? 0
		log(.info, "Open seat: \(openSeat)")
	}
}
