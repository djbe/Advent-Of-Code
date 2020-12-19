//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public struct Vector4<T: Numeric & Hashable>: VectorType {
	public let coordinates: [T]

	public init(_ coordinates: [T]) {
		self.coordinates = coordinates
	}

	public static var zero: Vector4<T> {
		[0, 0, 0, 0]
	}
}
