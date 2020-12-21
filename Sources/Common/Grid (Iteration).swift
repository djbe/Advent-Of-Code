//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension Grid {
	struct SlidingWindow: Sequence, IteratorProtocol {
		let grid: Grid<T>
		let size: Grid.Point
		let range: (row: ClosedRange<Int>, column: ClosedRange<Int>)
		var current: Grid.Point? = [0, 0]

		init(grid: Grid<T>, size: Point) {
			self.grid = grid
			self.size = size
			range = (
				0...(grid.data.count - size.y),
				0...((grid.data.first?.count ?? 0) - size.x)
			)
		}

		public mutating func next() -> (point: Point, contents: [ArraySlice<T>])? {
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
			let data = grid.data[current.y..<end.y].map { $0[current.x..<end.x] }

			return (current, data)
		}
	}

	func slidingWindow(size: Point) -> SlidingWindow {
		SlidingWindow(grid: self, size: size)
	}
}
