//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private final class Game {
	private let maximum: Int
	private let list: CircularList<Int>
	private let map: [Int: CircularList<Int>.Node]

	init(numbers: [Int]) {
		maximum = numbers.max() ?? 0
		list = CircularList(numbers)
		map = Dictionary(uniqueKeysWithValues: zip(numbers, list))
	}

	func play(rounds: Int) {
		guard var current = list.first else { return }

		for _ in 1...rounds {
			let pickup = list.prefix(3, after: current)
			let invalid = [current.value] + pickup.map(\.value)

			var destination = current.value
			while invalid.contains(destination) {
				destination = (destination - 1 >= 1) ? destination - 1 : maximum
			}

			if let target = map[destination] {
				list.insert(pickup, after: target)
			}
			current = current.next
		}
	}
}

struct Day23: Day {
	static let name = "Crab Cups"
	private let numbers: [Int]

	init(input: Input) {
		numbers = input.characters.compactMap(\.wholeNumberValue)
	}
}

// MARK: - Part 1

extension Game {
	var cupsAfterOne: LazyMapSequence<LazySequence<PrefixSequence<DropFirstSequence<CircularList<Int>.CircularIterator>>>.Elements, Int> {
		list.iterate(from: 1).dropFirst().prefix(map.count - 1).lazy.map(\.value)
	}
}

extension Day23 {
	mutating func part1() -> Any {
		logPart("Using your labeling, simulate 100 moves. What are the labels on the cups after cup 1?")

		let game = Game(numbers: numbers)
		game.play(rounds: 100)

		return Array(game.cupsAfterOne).map(\.description).joined()
	}
}

// MARK: - Part 2

extension Day23 {
	mutating func part2() -> Any {
		logPart("Determine which two cups will end up immediately clockwise of cup 1. What do you get if you multiply their labels together?")

		let max = numbers.max() ?? 0
		let expanded = numbers + Array((max + 1)...1_000_000)
		let game = Game(numbers: expanded)

		game.play(rounds: 10_000_000)

		return game.cupsAfterOne.prefix(2).product
	}
}
