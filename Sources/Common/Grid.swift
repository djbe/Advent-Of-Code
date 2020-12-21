//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public struct Grid<T> {
	public typealias Point = Vector2<Int>
	public var data: [[T]]

	public init(_ data: [[T]]) {
		self.data = data
	}
}

public extension Grid where T == Bool {
	init<T: Collection>(lines: T) where T.Element: StringProtocol {
		self.init(lines.map { $0.map { $0 != "." } })
	}
}

public extension Grid {
	var size: Point {
		[data.first?.count ?? 0, data.count]
	}

	func contains(_ point: Point) -> Bool {
		data.indices.contains(point.y) && data[point.y].indices.contains(point.x)
	}

	subscript(point: Point) -> T {
		get {
			data[point.y][point.x]
		}
		set {
			data[point.y][point.x] = newValue
		}
	}

	func getValue(at point: Point, default: T) -> T {
		guard contains(point) else { return `default` }
		return data[point.y][point.x]
	}

	/// Iterate over all available positions
	func iterate() -> [(point: Point, value: T)] {
		zip(0..., data).flatMap { index, row in zip(0..., row).map { (Point(x: $0, y: index), $1) } }
	}

	mutating func rotate() {
		data = data[0].indices.map { row in
			data.reversed().map { $0[row] }
		}
	}

	mutating func flip() {
		data = data.map { $0.reversed() }
	}
}

public extension Grid {
	/// Iterate over the grid in a certain direction, wrapping if needed, and only stopping when the handler returns `true`
	func step(from start: Point, direction: Point, wrap: Bool, handler: (Point) -> Bool) {
		var current = start
		repeat {
			current += direction
			if wrap, current.y < data.count {
				current = Point(x: current.x % data[current.y].count, y: current.y)
			}
		} while !handler(current)
	}

	/// Iterate over the grid towards a point, and only stopping when the handler returns `true`
	func step(from start: Point, to end: Point, handler: (Point) -> Bool) {
		let direction = end.angleVector(to: start)
		step(from: start, direction: direction, wrap: false) {
			handler($0)
		}
	}

	/// Iterate over the grid towards a point. Stops automatically just before it reaches `end`
	func stepBetween(start: Point, end: Point, handler: (Point) -> Void) {
		let direction = end.angleVector(to: start)
		step(from: start, direction: direction, wrap: false) {
			guard $0 != end else { return true }
			handler($0)
			return false
		}
	}
}

public extension Grid {
	/// Try  to rotate and/or flip the grid until it satisfies the given condition
	func tryToFit(check: (Grid<T>) -> Bool) -> Bool {
		var result = self
		if check(result) { return true }

		for _ in 1...4 {
			result.rotate()
			if check(result) { return true }
		}

		result.flip()
		if check(result) { return true }

		for _ in 1...4 {
			result.rotate()
			if check(result) { return true }
		}

		return false
	}
}

extension Grid: Equatable where T: Equatable {}
