//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private final class World<T: VectorType> where T.Real == Int {
	var points: Set<T>

	init<Line: StringProtocol>(lines: [Line]) {
		points = Set(zip(0..., lines.reversed()).flatMap { row, line in
			zip(0..., line).compactMap { column, character in
				guard character != "." else { return nil }
				return T([T.Real(exactly: column) ?? 0, T.Real(exactly: row) ?? 0] + Array(repeating: 0, count: T.zero.coordinates.count - 2))
			}
		})
	}

	func step() {
		var result: Set<T> = []

		for point in VectorCollectionIterator(points, margin: 1) {
			let adjacent = pointsAdjacent(to: point)
			let active = points.intersection(adjacent).count

			if points.contains(point), (2...3).contains(active) {
				result.insert(point)
			} else if !points.contains(point), active == 3 {
				result.insert(point)
			}
		}

		points = result
	}

	func pointsAdjacent(to center: T) -> [T] {
		directions.map { center + $0 }
	}

	// all unique combinations of -1...1 (for each axis), except for the zero coordinate
	lazy var directions: [T] = Array(repeating: -1...1, count: T.zero.coordinates.count)
		.flatMap { $0 }
		.combinations(ofCount: T.zero.coordinates.count)
		.uniqued()
		.map(T.init)
		.filter { $0 != T.zero }
}

extension World: CustomStringConvertible where T == Vector4<Int> {
	var description: String {
		points.descriptionMapping { points.contains($0) ? "#" : "." }
	}
}

struct Day17: Day {
	var name: String { "Conway Cubes" }

	private lazy var input = loadInputFile()
}

// MARK: - Part 1

extension Day17 {
	mutating func part1() -> Any {
		logPart("Starting with your given initial configuration, simulate six cycles. How many cubes are left in the active state after the sixth cycle?")

		let world = World<Vector3<Int>>(lines: input)
		for _ in 1...6 {
			world.step()
		}

		return world.points.count
	}
}

// MARK: - Part 2

extension Day17 {
	mutating func part2() -> Any {
		logPart("Starting with your given initial configuration, simulate six cycles in a 4-dimensional space. How many cubes are left in the active state after the sixth cycle?")

		let world = World<Vector4<Int>>(lines: input)
		for _ in 1...6 {
			world.step()
		}

		return world.points.count
	}
}
