//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private struct Path {
	typealias Point = Vector2<Int>
	typealias Tracer = (Character, Int) -> Point
	let points: [Point]

	init<T: StringProtocol>(instructions: [T], tracer: Tracer) {
		points = instructions.reduce(into: []) { points, movement in
			let value = Int(movement.dropFirst()) ?? 0
			points.append(tracer(movement[0], value))
		}
	}
}

struct Day12: Day {
	static let name = "Rain Risk"
	private let instructions: [Substring]

	init(input: Input) {
		instructions = input.rawLines
	}
}

// MARK: - Part 1

extension Day12 {
	private static func shipTracer() -> Path.Tracer {
		var current: (point: Path.Point, direction: Path.Point) = (.zero, [1, 0])

		return { instruction, value in
			switch instruction {
			case "N": current.point = current.point + [0, 1] * value
			case "S": current.point = current.point + [0, -1] * value
			case "E": current.point = current.point + [1, 0] * value
			case "W": current.point = current.point + [-1, 0] * value
			case "F": current.point = current.point + current.direction * value
			case "L": current.direction = current.direction.rotated(by: deg2rad(value))
			case "R": current.direction = current.direction.rotated(by: -deg2rad(value))
			default: preconditionFailure("Uknown instruction \(instruction)")
			}

			return current.point
		}
	}

	mutating func part1() -> Any {
		logPart("Figure out where the navigation instructions lead. What is the Manhattan distance between that location and the ship's starting position?")

		let path = Path(instructions: instructions, tracer: Self.shipTracer())
		let end = path.points.last ?? .zero

		return end.manhattanLength
	}
}

// MARK: - Part 2

extension Day12 {
	private static func waypointTracer(waypoint: Path.Point) -> Path.Tracer {
		var current: (point: Path.Point, direction: Path.Point) = (.zero, waypoint)

		return { instruction, value in
			switch instruction {
			case "N": current.direction = current.direction + [0, 1] * value
			case "S": current.direction = current.direction + [0, -1] * value
			case "E": current.direction = current.direction + [1, 0] * value
			case "W": current.direction = current.direction + [-1, 0] * value
			case "F": current.point = current.point + current.direction * value
			case "L": current.direction = current.direction.rotated(by: deg2rad(value))
			case "R": current.direction = current.direction.rotated(by: -deg2rad(value))
			default: preconditionFailure("Uknown instruction \(instruction)")
			}

			return current.point
		}
	}

	mutating func part2() -> Any {
		logPart("Figure out where the navigation instructions actually lead. What is the Manhattan distance between that location and the ship's starting position?")

		let path = Path(instructions: instructions, tracer: Self.waypointTracer(waypoint: [10, 1]))
		let end = path.points.last ?? .zero

		return end.manhattanLength
	}
}
