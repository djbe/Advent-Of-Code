import Foundation

public struct Grid<T> {
	public typealias Point = Vector<Int>
	public var data: [[T]]

	public init(_ data: [[T]]) {
		self.data = data
	}
}

public extension Grid {
	func contains(_ point: Point) -> Bool {
		data.indices.contains(point.y) && data[point.y].indices.contains(point.x)
	}

	subscript(point: Point) -> T {
		data[point.y][point.x]
	}

	/// Iterate over all available positions
	func iterate() -> [(point: Point, value: T)] {
		zip(0..., data).flatMap { y, row in zip(0..., row).map { (Point(x: $0, y: y), $1) } }
	}
}

public extension Grid {
	/// Iterate over the grid in a certain direction, wrapping if needed, and only stopping when the handler returns `true`
	func step(from start: Point, direction: Point, wrap: Bool, handler: (Point) -> Bool) {
		var current = start
		repeat {
			current += direction
			if wrap && current.y < data.count {
				current = Point(x: current.x % data[current.y].count, y: current.y)
			}
		} while !handler(current)
	}

	/// Iterate over the grid towards a point, and only stopping when the handler returns `true`
	func step(from start: Point, to end: Point, handler: (Point) -> Bool) {
		let direction = end.angleVector(to: start)
		step(from: start, direction: direction, wrap: false) {
			return handler($0)
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