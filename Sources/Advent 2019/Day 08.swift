//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day08: Day {
	static let name = "Space Image Format"
	private let bytes: [Int]
	private let size = 25 * 6

	init(input: Input) {
		bytes = input.lines[0].characters.compactMap(\.wholeNumberValue)
	}
}

// MARK: - Part 1

extension Day08 {
	mutating func part1() -> Any {
		logPart("find the layer that contains the fewest 0 digits. On that layer, what is the number of 1 digits multiplied by the number of 2 digits?")

		let layer = bytes.chunks(of: size).min { lhs, rhs in
			lhs.filter { $0 == 0 }.count < rhs.filter { $0 == 0 }.count
		} ?? []

		let ones = layer.filter { $0 == 1 }.count
		let twos = layer.filter { $0 == 2 }.count

		return ones * twos
	}
}

// MARK: - Part 2

extension Day08 {
	mutating func part2() -> Any {
		logPart("What message is produced after decoding your image?")

		let start = Array(repeating: 2, count: size)
		let result = bytes.chunks(of: size).reduce(into: start) { current, layer in
			current = zip(current, layer).map { $0 == 2 ? $1 : $0 }
		}

		log(.info, "Message:")
		result.chunks(of: 25).forEach {
			log(.info, $0.map { $0 == 0 ? " " : "X" }.joined())
		}

		return "TODO"
	}
}
