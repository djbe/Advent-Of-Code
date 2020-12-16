//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

struct Day15: Day {
	var name: String { "Rambunctious Recitation" }

	private lazy var input = [2, 0, 1, 7, 4, 14, 18]
}

// MARK: - Part 1

extension Day15 {
	private func calculateNumber(input: [Int], iterations: Int) -> Int {
		var indices: [Int: Int] = Dictionary(uniqueKeysWithValues: zip(input, 0...))
		var last = input.last ?? 0

		for index in input.count..<iterations {
			let next = indices[last].map { index - 1 - $0 } ?? 0
			indices[last] = index - 1
			last = next
		}

		return last
	}

	mutating func part1() -> Any {
		logPart("Given your starting numbers, what will be the 2020th number spoken?")

		return calculateNumber(input: input, iterations: 2_020)
	}
}

// MARK: - Part 2

extension Day15 {
	mutating func part2() -> Any {
		logPart("Given your starting numbers, what will be the 30000000th number spoken?")

		return calculateNumber(input: input, iterations: 30_000_000)
	}
}
