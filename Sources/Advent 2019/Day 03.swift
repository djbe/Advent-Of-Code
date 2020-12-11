import Algorithms
import Common

private struct Path {
	typealias Point = Vector2<Int>
	private let points: [Point]

	init<T: StringProtocol>(instructions: T) {
		points = instructions.split(separator: ",").reduce(into: []) { points, movement in
			points.append(contentsOf: Self.trace(movement: movement, from: points.last ?? .zero))
		}
	}

	private static func trace<T: StringProtocol>(movement: T, from point: Point) -> [Point] {
		let distance = Int(movement.dropFirst()) ?? 0

		switch movement[0] {
		case "U": return (point.y..<(point.y+distance)).map { Point(x: point.x, y: $0 + 1) }
		case "D": return ((point.y-distance+1)...point.y).reversed().map { Point(x: point.x, y: $0 - 1) }
		case "R": return (point.x..<(point.x+distance)).map { Point(x: $0 + 1, y: point.y) }
		case "L": return ((point.x-distance+1)...point.x).reversed().map { Point(x: $0 - 1, y: point.y) }
		default: preconditionFailure("Uknown direction \(movement[0])")
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
	var name: String { "Crossed Wires" }

	private lazy var paths = loadInputFile().map(Path.init)
	private lazy var intersections: Set<Path.Point> = []
}

// MARK: - Part 1

extension Day03 {
	mutating func part1() {
		logPart("What is the Manhattan distance from the central port to the closest intersection?")

		intersections = paths[0].intersections(with: paths[1])
		let closestIntersection = intersections.map { abs($0.x) + abs($0.y) }.min() ?? .max
		log(.info, "Closest intersection: \(closestIntersection)")
	}
}

// MARK: - Part 2

extension Day03 {
	mutating func part2() {
		logPart("What is the fewest combined steps the wires must take to reach an intersection?")

		let stepsToOptimal = intersections
			.map { point in paths.map { $0.stepsTaken(for: point) }.reduce(0, +) }
			.min() ?? .max
		log(.info, "Steps to optimal intersection: \(stepsToOptimal)")
	}
}
