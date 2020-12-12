//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

// swiftlint:disable identifier_name

public struct Vector2<T: Numeric & Hashable>: VectorType {
	public var x: T
	public var y: T

	public init(_ coordinates: [T]) {
		precondition(coordinates.count == 2, "Vector2 must init with 2 coordinates")
		self.init(x: coordinates[0], y: coordinates[1])
	}

	public init(x: T, y: T) {
		self.x = x
		self.y = y
	}

	public init(_ value: (T, T)) {
		x = value.0
		y = value.1
	}

	public var coordinates: [T] {
		[x, y]
	}
}

extension Vector2: CustomStringConvertible {
	public var description: String {
		"(x: \(x), y: \(y))"
	}
}

public extension Vector2 where T: Numeric {
	static var zero: Vector2 {
		Vector2(x: 0, y: 0)
	}

	static func -= (lhs: inout Vector2, rhs: Vector2) {
		lhs.x -= rhs.x
		lhs.y -= rhs.y
	}

	static func += (lhs: inout Vector2, rhs: Vector2) {
		lhs.x += rhs.x
		lhs.y += rhs.y
	}
}

public extension Vector2 where T: SignedNumeric & BinaryInteger {
	func angleVector(to vector: Vector2) -> Vector2 {
		let diffX = x - vector.x
		let diffY = y - vector.y
		let denominator = gcd(abs(diffX), abs(diffY))

		return Vector2(x: diffX / denominator, y: diffY / denominator)
	}

	func angle(to vector: Vector2) -> Float {
		let diffX = x - vector.x
		let diffY = y - vector.y
		let angle = atan2(Float(diffY), Float(diffX)) - .pi / 2
		return (angle + 2 * .pi).truncatingRemainder(dividingBy: 2 * .pi)
	}

	func rotated(by angle: Float) -> Vector2 {
		Vector2(
			x: T(round(cos(angle) * Float(x) - sin(angle) * Float(y))),
			y: T(round(sin(angle) * Float(x) + cos(angle) * Float(y)))
		)
	}
}
