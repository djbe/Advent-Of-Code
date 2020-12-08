//: [Previous Day](@previous)
//: # Day 5: Binary Boarding

import Foundation

struct BoardingPass {
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

let input = loadInputFile("input")
let passes = input.map(BoardingPass.init)

//: ### What is the highest seat ID on a boarding pass?

print("Highest ID: \(passes.map(\.id).max() ?? 0)")

//: ### What is the ID of your seat?

func findOpenSeat(passes: [BoardingPass]) -> Int {
	let existing = Set(passes.map(\.id))
	let range = (existing.min() ?? 0)...(existing.max() ?? 0)
	let available = Set(range.map { $0 })

	return available.subtracting(existing).first ?? 0
}

print("Open seat: \(findOpenSeat(passes: passes))")

//: [Next Day](@next)
