//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private final class World<Vector: VectorType> where Vector.Real == Int {
	var points: Set<Vector>

	init<T: StringProtocol>(lines: [Line<T>]) {
		points = Set(zip(0..., lines.reversed()).flatMap { row, line in
			zip(0..., line.characters).compactMap { column, character in
				guard character != "." else { return nil }
				return Vector([Vector.Real(exactly: column) ?? 0, Vector.Real(exactly: row) ?? 0] + Array(repeating: 0, count: Vector.zero.coordinates.count - 2))
			}
		})
	}

	func step() {
		var result: Set<Vector> = []

		for point in points.surroundingGrid(margin: 1) {
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

	func pointsAdjacent(to center: Vector) -> [Vector] {
		directions.map { center + $0 }
	}

	// all unique combinations of -1...1 (for each axis), except for the zero coordinate
	lazy var directions: [Vector] = Array(repeating: -1...1, count: Vector.zero.coordinates.count)
		.flatMap { $0 }
		.combinations(ofCount: Vector.zero.coordinates.count)
		.uniqued()
		.map(Vector.init)
		.filter { $0 != Vector.zero }
}

extension World: CustomStringConvertible where Vector == Vector4<Int> {
	var description: String {
		points.descriptionMapping { points.contains($0) ? "#" : "." }
	}
}

struct Day17: Day {
	static let name = "Conway Cubes"
	private let lines: [Line<Substring>]

	init(input: Input) {
		lines = input.lines
	}
}

// MARK: - Part 1

extension Day17 {
	mutating func part1() -> Any {
		logPart("Starting with your given initial configuration, simulate six cycles. How many cubes are left in the active state after the sixth cycle?")

		let world = World<Vector3<Int>>(lines: lines)
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

		let world = World<Vector4<Int>>(lines: lines)
		for _ in 1...6 {
			world.step()
		}

		return world.points.count
	}
}
