//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private final class World: CustomStringConvertible {
	typealias Point = Vector2<Int>

	let seats: Matrix<Bool>
	let seatMap: [Point: [Point]]
	var people: Matrix<Int>

	init(input: Input, seatFinder: (Point, Matrix<Bool>) -> [Point]) {
		let seats = Matrix<Bool>(input)
		let allSeats = seats.filter { seats[$0] }

		self.seats = seats
		seatMap = Dictionary(uniqueKeysWithValues: allSeats.map { ($0, seatFinder($0, seats)) })
		people = seats.map { _, _ in 0 }
	}

	var description: String {
		seats.descriptionMapping { point, value in value ? (people[point] == 1 ? "#" : "L") : "." }
	}

	func step(maxAdjacent: Int) -> Bool {
		var result = people
		defer { people = result }

		for (seat, adjacent) in seatMap {
			let sum = adjacent.map { people[$0] }.sum
			if people[seat] == 0, sum == 0 {
				result[seat] = 1
			} else if people[seat] == 1, sum >= maxAdjacent {
				result[seat] = 0
			}
		}

		return people == result
	}

	func stepUntilStable(maxAdjacent: Int) {
		for iteration in 1... {
			log(.debug, "Iteration #\(iteration)")
			if step(maxAdjacent: maxAdjacent) {
				break
			}
		}
	}

	var occupiedSeats: Int {
		people.map { people[$0] }.sum
	}
}

struct Day11: Day {
	static let name = "Seating System"
	private let input: Input

	init(input: Input) {
		self.input = input
	}
}

// MARK: - Part 1

extension World {
	static let directions: [Point] = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [1, -1], [-1, 1], [1, 1]].map(Point.init)

	static func seatsAdjacent(to center: Point, seats: Matrix<Bool>) -> [Point] {
		Self.directions.map { center + $0 }.filter { seats.get($0) ?? false }
	}
}

extension Day11 {
	mutating func part1() -> Any {
		logPart("Simulate your seating area by applying the seating rules repeatedly until no seats change state. How many seats end up occupied?")

		let world = World(input: input, seatFinder: World.seatsAdjacent(to:seats:))
		world.stepUntilStable(maxAdjacent: 4)

		return world.occupiedSeats
	}
}

// MARK: - Part 2

extension Matrix where Element == Bool {
	func find(from start: Point, direction: Point) -> Point? {
		step(from: start, direction: direction).dropFirst()
			.first { self[$0] }
	}
}

extension World {
	static func seatsWithLineOfSight(to center: Point, seats: Matrix<Bool>) -> [Point] {
		Self.directions.compactMap { seats.find(from: center, direction: $0) }
	}
}

extension Day11 {
	mutating func part2() -> Any {
		logPart("Given the new visibility method and the rule change for occupied seats becoming empty, once equilibrium is reached, how many seats end up occupied?")

		let world = World(input: input, seatFinder: World.seatsWithLineOfSight(to:seats:))
		world.stepUntilStable(maxAdjacent: 5)

		return world.occupiedSeats
	}
}
