//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private struct Path {
	typealias Point = Vector2<Int>
	private let points: [Point]

	init<T: StringProtocol>(instructions: Line<T>) {
		points = instructions.csvWords.reduce(into: []) { points, movement in
			points.append(contentsOf: Self.trace(movement: movement, from: points.last ?? .zero))
		}
	}

	private static func trace(movement: Word, from point: Point) -> [Point] {
		let distance = Int(movement.raw.dropFirst()) ?? 0

		switch movement.characters[0] {
		case "U": return (point.y..<(point.y + distance)).map { Point(x: point.x, y: $0 + 1) }
		case "D": return ((point.y - distance + 1)...point.y).reversed().map { Point(x: point.x, y: $0 - 1) }
		case "R": return (point.x..<(point.x + distance)).map { Point(x: $0 + 1, y: point.y) }
		case "L": return ((point.x - distance + 1)...point.x).reversed().map { Point(x: $0 - 1, y: point.y) }
		default: preconditionFailure("Uknown direction \(movement)")
		}
	}

	// we need to add 1 to count the origin
	func stepsTaken(for point: Point) -> Int {
		(points.firstIndex(of: point) ?? .max) + 1
	}

	func intersections(with path: Path) -> Set<Point> {
		Set(points).intersection(Set(path.points))
	}
}

struct Day03: Day {
	static let name = "Crossed Wires"
	private let paths: [Path]
	private var intersections: Set<Path.Point> = []

	init(input: Input) {
		paths = input.lines.map(Path.init(instructions:))
	}
}

// MARK: - Part 1

extension Day03 {
	mutating func part1() -> Any {
		logPart("What is the Manhattan distance from the central port to the closest intersection?")

		intersections = paths[0].intersections(with: paths[1])

		return intersections.map(\.manhattanLength).min() ?? 0
	}
}

// MARK: - Part 2

extension Day03 {
	mutating func part2() -> Any {
		logPart("What is the fewest combined steps the wires must take to reach an intersection?")

		return intersections
			.map { point in paths.map { $0.stepsTaken(for: point) }.sum }
			.min() ?? .max
	}
}
