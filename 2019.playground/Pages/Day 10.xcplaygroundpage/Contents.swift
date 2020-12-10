//: [Previous Day](@previous)
//: # Day 10: Monitoring Station

import Foundation

extension Grid where T == Bool {
	init<T: StringProtocol>(lines: [T]) {
		self.init(lines.map { $0.map { $0 == "#" } })
	}
}

let input = loadInputFile("input")
let field = Grid<Bool>(lines: input)

//: ### Find the best location for a new monitoring station. How many other asteroids can be detected from that location?

extension Grid where T == Bool {
	func haveLineOfSightBetween(_ lhs: Point, _ rhs: Point) -> Bool {
		var hit = false
		step(from: lhs, to: rhs) {
			hit = hit || self[$0]
			return hit
		}
		return !hit
	}
}

var asteroids: [Grid.Point] = field.iterate().filter { $0.value }.map(\.point)
let station: (point: Grid.Point, count: Int) = asteroids.map { asteroid in
	let count = asteroids.filter { $0 != asteroid }.filter { field.haveLineOfSightBetween(asteroid, $0) }.count
	return (asteroid, count)
}.max { $0.1 < $1.1 }!

print("Best station at \(station.point.x),\(station.point.y) sees \(station.count)")

//: ### what do you get if you multiply its X coordinate by 100 and then add its Y coordinate?

extension Grid where T == Bool {
	func countAsteroidsBetween(_ lhs: Point, _ rhs: Point) -> Int {
		var result = 0
		stepBetween(start: lhs, end: rhs) {
			result += self[$0] ? 1 : 0
		}
		return result
	}
}

asteroids = asteroids.filter { $0 != station.point }
let orderedByDestruction: [(point: Grid.Point, count: Int, angle: Float)] = asteroids.map { asteroid in
	(
		point: asteroid,
		count: field.countAsteroidsBetween(station.point, asteroid),
		angle: station.point.angle(to: asteroid)
	)
}.sorted { lhs, rhs in
	lhs.count == rhs.count ? lhs.angle < rhs.angle : lhs.count < rhs.count
}

let guess = orderedByDestruction[199].point
print("200th asteroid is \(guess.x),\(guess.y) --> \(guess.x * 100 + guess.y)")

//: [Next Day](@next)
