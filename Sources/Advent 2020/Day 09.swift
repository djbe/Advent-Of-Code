import Algorithms
import Common

struct Day09: Day {
	var name: String { "Encoding Error" }

	private lazy var numbers = loadInputFile().compactMap { Int(String($0)) }
	private lazy var invalidNumber = 0
}

// MARK: - Part 1

extension Day09 {
	func check(sequence: [Int], history: Int) -> Int? {
		sequence.slidingWindows(ofCount: history + 1).first { numbers in
			let newNumber = numbers.last ?? 0
			return !Array(numbers.prefix(history)).permutations(ofCount: 2)
				.contains { $0.reduce(0, +) == newNumber }
		}?.last
	}

	mutating func part1() {
		logPart("What is the first number that does not have this property?")

		invalidNumber = check(sequence: numbers, history: 25) ?? 0
		log(.info, "Non-matching number: \(invalidNumber)")
	}
}

// MARK: - Part 2

extension Day09 {
	func findWeakness(sequence: [Int], invalid: Int) -> [Int] {
		for size in 3... {
			if let result = sequence.slidingWindows(ofCount: size).first(where: { $0.reduce(0, +) == invalid }) {
				return Array(result)
			}
		}
		return []
	}

	mutating func part2() {
		logPart("What is the encryption weakness in your XMAS-encrypted list of numbers?")

		let result = findWeakness(sequence: numbers, invalid: invalidNumber)
		let weakness = (result.min() ?? 0) + (result.max() ?? 0)
		log(.info, "Found weakness: \(result) --> \(weakness)")
	}
}
