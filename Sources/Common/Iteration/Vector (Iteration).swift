//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public struct VectorCollectionIterator<Vector: VectorType>: Sequence, IteratorProtocol where Vector.Real: Comparable {
	let min: [Vector.Real]
	let max: [Vector.Real]
	let target: [Vector.Real]
	let direction: [Vector.Real]
	// swiftlint:disable:next discouraged_optional_collection
	var current: [Vector.Real]?

	init<T: Collection>(_ collection: T, margin: Vector.Real = 0) where T.Element == Vector {
		var min = Vector.zero.coordinates
		var max = Vector.zero.coordinates
		for vector in collection {
			min = zip(vector.coordinates, min).map(Swift.min)
			max = zip(vector.coordinates, max).map(Swift.max)
		}
		min = min.map { $0 - margin }
		max = max.map { $0 + margin }

		var direction: [Vector.Real] = Array(repeating: 1, count: min.count)
		var current = min
		var target = max
		if current.count >= 2 {
			direction[1] = -1
			current[1] = max[1]
			target[1] = min[1]
		}

		self.min = min
		self.max = max
		self.target = target
		self.direction = direction
		self.current = current
	}

	public mutating func next() -> Vector? {
		guard let current = current else { return nil }

		defer {
			if current == target {
				self.current = nil
			} else {
				var next = current
				for index in next.indices {
					next[index] += direction[index]
					if direction[index] > 0, next[index] > max[index] {
						next[index] = min[index]
					} else if direction[index] < 0, next[index] < min[index] {
						next[index] = max[index]
					} else {
						break
					}
				}
				self.current = next
			}
		}

		return Vector(current)
	}
}

public extension Collection where Element: VectorType, Element.Real: Comparable {
	func surroundingGrid(margin: Element.Real = 0) -> VectorCollectionIterator<Element> {
		VectorCollectionIterator(self, margin: margin)
	}
}
