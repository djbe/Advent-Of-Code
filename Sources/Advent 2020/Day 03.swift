//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private extension Grid where T == Bool {
	func countTrees(slope: Point) -> Int {
		var result = 0

		step(from: .zero, direction: slope, wrap: true) {
			guard contains($0) else { return true }
			result += self[$0] ? 1 : 0
			return false
		}

		return result
	}
}

struct Day03: Day {
	var name: String { "Toboggan Trajectory" }

	private lazy var grid = Grid<Bool>(lines: loadInputFile())
}

// MARK: - Part 1

extension Day03 {
	mutating func part1() -> Any {
		logPart("Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?")

		return grid.countTrees(slope: Grid.Point(x: 3, y: 1))
	}
}

// MARK: - Part 2

extension Day03 {
	mutating func part2() -> Any {
		logPart("What do you get if you multiply together the number of trees encountered on each of the listed slopes?")

		let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)].map(Grid.Point.init)
		return slopes.map(grid.countTrees(slope:))
			.reduce(1, *)
	}
}
