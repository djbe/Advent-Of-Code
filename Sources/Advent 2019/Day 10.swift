//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private extension Grid where T == Bool {
	init<T: StringProtocol>(lines: [T]) {
		self.init(lines.map { $0.map { $0 == "#" } })
	}
}

struct Day10: Day {
	var name: String { "Monitoring Station" }

	private lazy var field = Grid<Bool>(lines: loadInputFile())
	private lazy var asteroids: [Grid.Point] = field.iterate().filter { $0.value }.map(\.point)
	private lazy var station: Grid.Point = .zero
}

// MARK: - Part 1

private extension Grid where T == Bool {
	func haveLineOfSightBetween(_ lhs: Point, _ rhs: Point) -> Bool {
		var hit = false
		step(from: lhs, to: rhs) {
			guard $0 != rhs else { return true }
			hit = hit || self[$0]
			return hit
		}
		return !hit
	}
}

extension Day10 {
	mutating func part1() -> Any {
		logPart("Find the best location for a new monitoring station. How many other asteroids can be detected from that location?")

		let station: (point: Grid.Point, count: Int) = asteroids
			.map { asteroid in
				let count = asteroids.filter { $0 != asteroid }.filter { field.haveLineOfSightBetween(asteroid, $0) }.count
				return (asteroid, count)
			}
			.max { $0.1 < $1.1 }!
		self.station = station.point
		log(.info, "Best station at \(station.point.x),\(station.point.y) sees \(station.count) asteroids")

		return station.count
	}
}

// MARK: - Part 2

private extension Grid where T == Bool {
	func countAsteroidsBetween(_ lhs: Point, _ rhs: Point) -> Int {
		var result = 0
		stepBetween(start: lhs, end: rhs) {
			result += self[$0] ? 1 : 0
		}
		return result
	}
}

extension Day10 {
	mutating func part2() -> Any {
		logPart("What do you get if you multiply its X coordinate by 100 and then add its Y coordinate?")

		let asteroids = self.asteroids.filter { $0 != station }
		let orderedByDestruction: [(point: Grid.Point, count: Int, angle: Float)] = asteroids
			.map { asteroid in
				(
					point: asteroid,
					count: field.countAsteroidsBetween(station, asteroid),
					angle: station.angle(to: asteroid)
				)
			}
			.sorted { lhs, rhs in
				lhs.count == rhs.count ? lhs.angle < rhs.angle : lhs.count < rhs.count
			}

		let guess = orderedByDestruction[199].point
		log(.info, "200th asteroid is \(guess.x),\(guess.y)")

		return guess.x * 100 + guess.y
	}
}
