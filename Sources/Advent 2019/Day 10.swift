//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day10: Day {
	var name: String { "Monitoring Station" }

	private lazy var field = Matrix<Bool>(lines: loadInputFile())
	private lazy var asteroids: [Matrix.Point] = field.iterate().filter { field[$0] }
	private lazy var station: Matrix.Point = .zero
}

// MARK: - Part 1

private extension Matrix where T == Bool {
	func haveLineOfSightBetween(_ lhs: Point, _ rhs: Point) -> Bool {
		!step(from: lhs, to: rhs).dropFirst().dropLast().contains { self[$0] }
	}
}

extension Day10 {
	mutating func part1() -> Any {
		logPart("Find the best location for a new monitoring station. How many other asteroids can be detected from that location?")

		let station: (point: Matrix.Point, count: Int) = asteroids
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

private extension Matrix where T == Bool {
	func countAsteroidsBetween(_ lhs: Point, _ rhs: Point) -> Int {
		step(from: lhs, to: rhs).dropFirst().dropLast().map { self[$0] ? 1 : 0 }.sum
	}
}

extension Day10 {
	mutating func part2() -> Any {
		logPart("What do you get if you multiply its X coordinate by 100 and then add its Y coordinate?")

		let asteroids = self.asteroids.filter { $0 != station }
		let orderedByDestruction: [(point: Matrix.Point, count: Int, angle: Float)] = asteroids
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
