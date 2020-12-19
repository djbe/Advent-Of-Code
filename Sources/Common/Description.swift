//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension Collection where Element == Vector2<Int> {
	func descriptionMapping(mapper: (Element) -> Character) -> String {
		var previous: Element?

		return String(VectorCollectionIterator(self)
			.flatMap { (point: Element) -> [Character] in
				defer { previous = point }
				let character = mapper(point)
				if previous?.y != point.y {
					return ["\n", character]
				} else {
					return [character]
				}
			}
			.dropFirst()
		)
	}
}

public extension Collection where Element == Vector3<Int> {
	func descriptionMapping(mapper: (Element) -> Character) -> String {
		var previous: Element?

		return String(VectorCollectionIterator(self)
			.flatMap { (point: Element) -> [Character] in
				defer { previous = point }
				let character = mapper(point)
				if previous?.z != point.z {
					return Array("\n\nz=\(point.z)\n\(character)")
				} else if previous?.y != point.y {
					return ["\n", character]
				} else {
					return [character]
				}
			}
			.dropFirst(2)
		)
	}
}

public extension Collection where Element == Vector4<Int> {
	func descriptionMapping(mapper: (Element) -> Character) -> String {
		var previous: Element?

		return String(VectorCollectionIterator(self)
			.flatMap { (point: Element) -> [Character] in
				defer { previous = point }
				let character = mapper(point)
				if previous?.coordinates[2...] != point.coordinates[2...] {
					return Array("\n\nplane=\(point.coordinates[2...])\n\(character)")
				} else if previous?.coordinates[1] != point.coordinates[1] {
					return ["\n", character]
				} else {
					return [character]
				}
			}
			.dropFirst(2)
		)
	}
}
