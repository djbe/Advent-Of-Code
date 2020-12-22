//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

// swiftlint:disable identifier_name

public struct Vector4<T: Numeric & Hashable>: VectorType {
	public var x: T
	public var y: T
	public var z: T
	public var w: T

	public init(_ coordinates: [T]) {
		precondition(coordinates.count == 4, "Vector4 must init with 4 coordinates")
		self.init(x: coordinates[0], y: coordinates[1], z: coordinates[2], w: coordinates[3])
	}

	public init(x: T, y: T, z: T, w: T) {
		self.x = x
		self.y = y
		self.z = z
		self.w = w
	}

	// swiftlint:disable:next large_tuple
	public init(_ value: (T, T, T, T)) {
		x = value.0
		y = value.1
		z = value.2
		w = value.3
	}

	public var coordinates: [T] {
		[x, y, z, w]
	}
}

extension Vector4: CustomStringConvertible {
	public var description: String {
		"(x: \(x), y: \(y), z: \(z))"
	}
}

public extension Vector4 {
	static var zero: Vector4 {
		Vector4(x: 0, y: 0, z: 0, w: 0)
	}

	static func -= (lhs: inout Vector4, rhs: Vector4) {
		lhs.x -= rhs.x
		lhs.y -= rhs.y
		lhs.z -= rhs.z
		lhs.w -= rhs.w
	}

	static func += (lhs: inout Vector4, rhs: Vector4) {
		lhs.x += rhs.x
		lhs.y += rhs.y
		lhs.z += rhs.z
		lhs.w += rhs.w
	}
}
