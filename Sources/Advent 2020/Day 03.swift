//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private extension Matrix where T == Bool {
	func countTrees(slope: Point) -> Int {
		step(from: .zero, direction: slope, wrapX: true)
			.map { self[$0] ? 1 : 0 }
			.sum
	}
}

struct Day03: Day {
	var name: String { "Toboggan Trajectory" }

	private lazy var grid = Matrix<Bool>(lines: loadInputFile())
}

// MARK: - Part 1

extension Day03 {
	mutating func part1() -> Any {
		logPart("Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?")

		return grid.countTrees(slope: Matrix.Point(x: 3, y: 1))
	}
}

// MARK: - Part 2

extension Day03 {
	mutating func part2() -> Any {
		logPart("What do you get if you multiply together the number of trees encountered on each of the listed slopes?")

		let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)].map(Matrix.Point.init)
		return slopes.map(grid.countTrees(slope:))
			.product
	}
}
