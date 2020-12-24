//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public struct Matrix<Element> {
	public typealias Point = Vector2<Int>
	public var data: [[Element]]

	public init(_ data: [[Element]]) {
		self.data = data
	}
}

public extension Matrix where Element == Bool {
	init<C: Collection, T: StringProtocol>(_ lines: C, stringType: T.Type = T.self) where C.Element == Line<T> {
		self.init(lines.map { $0.characters.map { $0 != "." } })
	}

	init(_ input: Input) {
		self.init(input.lines)
	}
}

public extension Matrix {
	var size: Point {
		[data.first?.count ?? 0, data.count]
	}

	func has(_ point: Point) -> Bool {
		data.indices.contains(point.y) && data[point.y].indices.contains(point.x)
	}

	subscript(point: Point) -> Element {
		get { data[point.y][point.x] }
		set { data[point.y][point.x] = newValue }
	}

	func get(_ point: Point) -> Element? {
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

	mutating func rotated() -> Matrix<Element> {
		var result = self
		result.rotate()
		return result
	}

	mutating func mirror() {
		data = data.map { $0.reversed() }
	}

	func mirrorred() -> Matrix<Element> {
		var result = self
		result.mirror()
		return result
	}

	mutating func flip() {
		data.reverse()
	}

	func flipped() -> Matrix<Element> {
		var result = self
		result.flip()
		return result
	}
}

public extension Matrix {
	/// Try  to rotate and/or flip the grid until it satisfies the given condition
	func tryToFit(check: (Matrix<Element>) -> Bool) -> Bool {
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

extension Matrix: Equatable where Element: Equatable {}
extension Matrix: Hashable where Element: Hashable {}
