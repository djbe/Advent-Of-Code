//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day10: Day {
	static let name = "Adapter Array"

	private let adapters: [Int]
	private let device: Int
	private let sequence: [Int]

	init(input: Input) {
		adapters = input.lines.compactMap(\.integer).sorted(by: >)
		device = (adapters.first ?? 0) + 3
		sequence = [device] + adapters + [0]
	}
}

// MARK: - Part 1

extension Day10 {
	mutating func part1() -> Any {
		logPart("What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?")

		let diffs = Dictionary(grouping: zip(sequence, sequence.dropFirst()).map(-)) { $0 }.mapValues(\.count)

		return diffs[1, default: 0] * diffs[3, default: 0]
	}
}

// MARK: - Part 2

extension Day10 {
	func countPaths(in chunk: ArraySlice<Int>) -> Int {
		guard chunk.count > 2 else { return 1 }

		// where can we jump to from here?
		let start = chunk.first ?? 0
		let options = zip(1..., chunk.dropFirst().prefix(3)).filter { $1 <= start + 3 }

		return options.map { countPaths(in: chunk.dropFirst($0.0)) }.sum
	}

	mutating func part2() -> Any {
		logPart("What is the total number of distinct ways you can arrange the adapters to connect the charging outlet to your device?")

		// find chunks in the sequence that are 3 apart --> where the combinations are
		var last = 0
		let chunks = Array(sequence.reversed()).chunked { _, rhs in
			defer { last = rhs }
			return rhs < last + 3
		}

		return chunks.map(countPaths(in:)).product
	}
}
