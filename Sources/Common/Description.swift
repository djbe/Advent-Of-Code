//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension Array where Element == Vector2<Int> {
	func description(mapper: (Element) -> Character) -> String {
		let minX = map(\.x).min() ?? 0
		let maxX = map(\.x).max() ?? 0
		let minY = map(\.y).min() ?? 0
		let maxY = map(\.y).max() ?? 0

		return (minY...maxY).reversed()
			.map { row in
				String((minX...maxX).map { column in mapper(.init(x: column, y: row)) })
			}
			.joined(separator: "\n")
	}
}
