//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

// swiftlint:disable identifier_name

public struct Vector3<T: Numeric & Hashable>: VectorType {
	public var x: T
	public var y: T
	public var z: T

	public init(_ coordinates: [T]) {
		precondition(coordinates.count == 3, "Vector3 must init with 3 coordinates")
		self.init(x: coordinates[0], y: coordinates[1], z: coordinates[2])
	}

	public init(x: T, y: T, z: T) {
		self.x = x
		self.y = y
		self.z = z
	}

	// swiftlint:disable:next large_tuple
	public init(_ value: (T, T, T)) {
		x = value.0
		y = value.1
		z = value.2
	}

	public var coordinates: [T] {
		[x, y, z]
	}
}

extension Vector3: CustomStringConvertible {
	public var description: String {
		"(x: \(x), y: \(y), z: \(z))"
	}
}

public extension Vector3 where T: Numeric {
	static var zero: Vector3 {
		Vector3(x: 0, y: 0, z: 0)
	}

	static func -= (lhs: inout Vector3, rhs: Vector3) {
		lhs.x -= rhs.x
		lhs.y -= rhs.y
		lhs.z -= rhs.z
	}

	static func += (lhs: inout Vector3, rhs: Vector3) {
		lhs.x += rhs.x
		lhs.y += rhs.y
		lhs.z += rhs.z
	}
}
