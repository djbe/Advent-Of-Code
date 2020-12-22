//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public struct Matrix<T> {
	public typealias Point = Vector2<Int>
	public var data: [[T]]

	public init(_ data: [[T]]) {
		self.data = data
	}
}

public extension Matrix where T == Bool {
	init<T: Collection>(lines: T) where T.Element: StringProtocol {
		self.init(lines.map { $0.map { $0 != "." } })
	}
}

public extension Matrix {
	var size: Point {
		[data.first?.count ?? 0, data.count]
	}

	func has(_ point: Point) -> Bool {
		data.indices.contains(point.y) && data[point.y].indices.contains(point.x)
	}

	subscript(point: Point) -> T {
		get { data[point.y][point.x] }
		set { data[point.y][point.x] = newValue }
	}

	func get(_ point: Point) -> T? {
		guard has(point) else { return nil }
		return data[point.y][point.x]
	}
}

// MARK: - Manipulation

public extension Matrix {
	mutating func rotate() {
		data = data[0].indices.map { row in
			data.reversed().map { $0[row] }
		}
	}

	mutating func rotated() -> Matrix<T> {
		var result = self
		result.rotate()
		return result
	}

	mutating func mirror() {
		data = data.map { $0.reversed() }
	}

	func mirrorred() -> Matrix<T> {
		var result = self
		result.mirror()
		return result
	}

	mutating func flip() {
		data.reverse()
	}

	func flipped() -> Matrix<T> {
		var result = self
		result.flip()
		return result
	}
}

public extension Matrix {
	/// Try  to rotate and/or flip the grid until it satisfies the given condition
	func tryToFit(check: (Matrix<T>) -> Bool) -> Bool {
		var result = self
		if check(result) { return true }

		for _ in 1...4 {
			result.rotate()
			if check(result) { return true }
		}

		result.mirror()
		if check(result) { return true }

		for _ in 1...4 {
			result.rotate()
			if check(result) { return true }
		}

		return false
	}
}

extension Matrix: Equatable where T: Equatable {}
extension Matrix: Hashable where T: Hashable {}
