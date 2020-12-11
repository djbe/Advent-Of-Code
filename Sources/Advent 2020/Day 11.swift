import Algorithms
import Common
import Foundation

private final class World: CustomStringConvertible {
	typealias Point = Vector2<Int>

	let seats: Grid<Bool>
	let seatMap: [Point: [Point]]
	var people: Grid<Int>

	init<T: StringProtocol>(lines: [T], seatFinder: (Point, Grid<Bool>) -> [Point]) {
		let seats = Grid<Bool>(lines.map { $0.map { $0 != "." } })
		let allSeats = seats.iterate().filter { $0.value }.map(\.point)

		self.seats = seats
		seatMap = Dictionary(uniqueKeysWithValues: allSeats.map { ($0, seatFinder($0, seats)) })
		people = .init(lines.map { Array(repeating: 0, count: $0.count) })
	}

	var description: String {
		seats.iterate().map { $0.value ? (people[$0.point] == 1 ? "#" : "L" ) : "." }.chunks(of: seats.data[0].count).map { $0.joined() }.joined(separator: "\n")
	}

	func step(maxAdjacent: Int) -> Bool {
		var result = people
		defer { people = result }

		for (seat, adjacent) in seatMap {
			let sum = adjacent.map { people[$0] }.reduce(0, +)
			if people[seat] == 0 && sum == 0 {
				result[seat] = 1
			} else if people[seat] == 1 && sum >= maxAdjacent {
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
		people.iterate().map(\.value).reduce(0, +)
	}
}

struct Day11: Day {
	var name: String { "Seating System" }

	lazy var input = loadInputFile()
}

// MARK: - Part 1

extension World {
	static let directions: [Point] = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [1, -1], [-1, 1], [1, 1]].map(Point.init)

	static func seatsAdjacent(to center: Point, seats: Grid<Bool>) -> [Point] {
		Self.directions.map { center + $0 }.filter { seats.getValue(at: $0, default: false) }
	}
}

extension Day11 {
	mutating func part1() {
		logPart("Simulate your seating area by applying the seating rules repeatedly until no seats change state. How many seats end up occupied?")

		let world = World(lines: input, seatFinder: World.seatsAdjacent(to:seats:))
		world.stepUntilStable(maxAdjacent: 4)

		log(.info, "Occupied seats: \(world.occupiedSeats)")
	}
}

// MARK: - Part 2

extension Grid where T == Bool {
	func find(from start: Point, direction: Point) -> Point? {
		var result: Point? = nil
		step(from: start, direction: direction, wrap: false) { point in
			if getValue(at: point, default: false) {
				result = point
			}
			return result != nil || !contains(point)
		}
		return result
	}
}

extension World {
	static func seatsWithLineOfSight(to center: Point, seats: Grid<Bool>) -> [Point] {
		Self.directions.compactMap { seats.find(from: center, direction: $0) }
	}
}

extension Day11 {
	mutating func part2() {
		logPart("Given the new visibility method and the rule change for occupied seats becoming empty, once equilibrium is reached, how many seats end up occupied?")

		let world = World(lines: input, seatFinder: World.seatsWithLineOfSight(to:seats:))
		world.stepUntilStable(maxAdjacent: 5)

		log(.info, "Occupied seats: \(world.occupiedSeats)")
	}
}
