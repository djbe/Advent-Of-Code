//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

extension Matrix: Sequence {
	public struct SimpleIterator: Sequence, IteratorProtocol {
		let matrix: Matrix<Element>
		var current: Matrix.Point? = [0, 0]

		public mutating func next() -> Matrix.Point? {
			guard let current = current else { return nil }

			defer {
				var next = current + [1, 0]
				if next.x >= matrix.size.x {
					next = [0, next.y + 1]
				}
				if next.y < matrix.size.y {
					self.current = next
				} else {
					self.current = nil
				}
			}

			return current
		}
	}

	public func makeIterator() -> SimpleIterator {
		SimpleIterator(matrix: self)
	}

	public func map<O>(_ transform: (_ point: Point, _ value: Element) -> O) -> Matrix<O> {
		var result = [[O]](repeating: [], count: data.count)

		for point in self {
			result[point.y].append(transform(point, self[point]))
		}

		return Matrix<O>(result)
	}
}

public extension Matrix {
	struct SlidingWindow: Sequence, IteratorProtocol {
		let matrix: Matrix<Element>
		let size: Matrix.Point
		let range: (row: ClosedRange<Int>, column: ClosedRange<Int>)
		var current: Matrix.Point? = [0, 0]

		init(matrix: Matrix<Element>, size: Point) {
			self.matrix = matrix
			self.size = size
			range = (
				0...(matrix.data.count - size.y),
				0...((matrix.data.first?.count ?? 0) - size.x)
			)
		}

		public mutating func next() -> (point: Point, contents: [ArraySlice<Element>])? {
			guard let current = current else { return nil }

			defer {
				var next: Point = current + [1, 0]
				if !range.column.contains(next.x) {
					next = [0, next.y + 1]
				}
				if range.row.contains(next.y) {
					self.current = next
				} else {
					self.current = nil
				}
			}

			let end = current + size
			let data = matrix.data[current.y..<end.y].map { $0[current.x..<end.x] }

			return (current, data)
		}
	}

	func slidingWindow(size: Point) -> SlidingWindow {
		SlidingWindow(matrix: self, size: size)
	}
}

public extension Matrix {
	struct PointStepper: Sequence, IteratorProtocol {
		let matrix: Matrix<Element>
		let direction: Point
		let end: Point?
		let wrap: (x: Bool, y: Bool)
		var current: Point?

		init(matrix: Matrix<Element>, start: Point, direction: Point, end: Point?, wrapX: Bool, wrapY: Bool) {
			self.matrix = matrix
			self.direction = direction
			self.end = end
			wrap = (wrapX, wrapY)
			current = start
		}

		public mutating func next() -> Point? {
			guard let current = current else { return nil }

			defer {
				if current == end {
					self.current = nil
				} else {
					var next: Point = current + direction
					if wrap.x { next.x = next.x % matrix.size.x }
					if wrap.y { next.y = next.y % matrix.size.y }
					if matrix.has(next) {
						self.current = next
					} else {
						self.current = nil
					}
				}
			}

			return current
		}
	}

	/// Iterate over the matrix in a certain direction, wrapping if needed
	func step(from start: Point, direction: Point, wrapX: Bool = false, wrapY: Bool = false) -> PointStepper {
		PointStepper(matrix: self, start: start, direction: direction, end: nil, wrapX: wrapX, wrapY: wrapY)
	}

	/// Iterate over the matrix to a point, wrapping if needed. Will stop at the given end point.
	func step(from start: Point, to end: Point, wrapX: Bool = false, wrapY: Bool = false) -> PointStepper {
		let direction = end.angleVector(to: start)
		return PointStepper(matrix: self, start: start, direction: direction, end: end, wrapX: wrapX, wrapY: wrapY)
	}

	/// Iterate over the matrix towards a point (as a direction), only stopping if one of the wrap is `false`
	func step(from start: Point, towards end: Point, wrapX: Bool = false, wrapY: Bool = false) -> PointStepper {
		let direction = end.angleVector(to: start)
		return PointStepper(matrix: self, start: start, direction: direction, end: nil, wrapX: wrapX, wrapY: wrapY)
	}
}
