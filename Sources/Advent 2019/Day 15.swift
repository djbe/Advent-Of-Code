//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private enum Tile: Int {
	case unknown = -1, wall, empty, oxygenSystem
}

private final class RepairDroid {
	typealias Point = Vector2<Int>
	private let program: Program
	private var world: [Point: Tile] = [.zero: .empty]
	private static let directions = [[0, 1], [0, -1], [-1, 0], [1, 0]].map(Point.init)

	init(program: Program) {
		self.program = program
	}

	func search() {
		var queue: [Point] = [.zero]
		var seen: [Point: Computer] = [Point(x: 0, y: 0): Computer(program)]

		while !queue.isEmpty {
			let current = queue.removeFirst()
			for (command, position) in zip(1..., Self.directions).map({ ($0, current + $1) }) where seen[position] == nil {
				var computer = seen[current, default: Computer(program)]
				computer.input = BlockingChannel(command)

				world[position] = Tile(rawValue: computer.runUntilOutput())
				seen[position] = computer
				if world[position] != .wall {
					queue.append(position)
				}
			}
		}
	}
}

extension RepairDroid {
	func description(for position: Point) -> String {
		let points = (world.keys + [position])
		return points.descriptionMapping {
			if position == $0 {
				return "D"
			} else {
				switch world[$0] {
				case .wall: return "#"
				case .empty: return "."
				case .oxygenSystem: return "O"
				default: return " "
				}
			}
		}
	}
}

struct Day15: Day {
	static let name = "Oxygen System"
	private let program: Program

	init(input: Input) {
		program = Program(code: input.lines)
	}
}

// MARK: - Part 1

extension RepairDroid {
	func stepsToOxygen() -> Int {
		var queue: [(steps: Int, point: Point)] = [(0, .zero)]
		var seen: Set<Point> = []

		while !queue.isEmpty {
			let (steps, point) = queue.removeFirst()
			seen.insert(point)

			for position in Self.directions.map({ point + $0 }) where !seen.contains(position) {
				if world[position, default: .unknown] != .wall {
					queue.append((steps + 1, position))
				}
				if world[position, default: .unknown] == .oxygenSystem {
					return steps + 1
				}
			}
		}

		return -1
	}
}

extension Day15 {
	mutating func part1() -> Any {
		logPart("What is the fewest number of movement commands required to move the repair droid from its starting position to the location of the oxygen system?")

		let droid = RepairDroid(program: program)
		droid.search()

		return droid.stepsToOxygen()
	}
}

// MARK: - Part 2

extension RepairDroid {
	func timeToFillOxygen() -> Int {
		let start = world.first { $0.value == .oxygenSystem }?.key ?? .zero
		var iterations = 0

		let spaces = Set(world.filter { $0.value == .empty || $0.key == start }.keys)
		var done = Set([start])
		var edge = done

		while !done.isSuperset(of: spaces) {
			let expanded = Set(edge.flatMap { point in
				Self.directions.map { $0 + point }.filter { world[$0, default: .unknown] != .wall }
			})

			edge = expanded.subtracting(done)
			done.formUnion(expanded)
			iterations += 1
		}

		return iterations
	}
}

extension Day15 {
	mutating func part2() -> Any {
		logPart("Use the repair droid to get a complete map of the area. How many minutes will it take to fill with oxygen?")

		let droid = RepairDroid(program: program)
		droid.search()

		return droid.timeToFillOxygen()
	}
}
