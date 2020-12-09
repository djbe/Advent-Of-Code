import Foundation

public struct Vector<T: Equatable>: Equatable {
	public var x: T
	public var y: T

	public init(x: T, y: T) {
		self.x = x
		self.y = y
	}

	public init(_ value: (T, T)) {
		x = value.0
		y = value.1
	}
}

extension Vector: Hashable where T: Hashable {}

public extension Vector {
	var description: String {
		"(\(x), \(y))"
	}

	var debugDescription: String {
		"(\(x), \(y))"
	}
}

public extension Vector where T: Numeric {
	static var zero: Vector {
		Vector(x: 0, y: 0)
	}

	static func -(lhs: Vector, rhs: Vector) -> Vector {
		Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}

	static func +(lhs: Vector, rhs: Vector) -> Vector {
		Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
	}

	static func -=(lhs: inout Vector, rhs: Vector) {
		lhs.x -= rhs.x
		lhs.y -= rhs.y
	}

	static func +=(lhs: inout Vector, rhs: Vector) {
		lhs.x += rhs.x
		lhs.y += rhs.y
	}
}

public extension Vector where T: SignedNumeric & BinaryInteger {
	func angleVector(to vector: Vector) -> Vector {
		let diffX = x - vector.x
		let diffY = y - vector.y
		let denominator = gcd(abs(diffX), abs(diffY))

		return Vector(x: diffX / denominator, y: diffY / denominator)
	}

	func angle(to vector: Vector) -> Float {
		let diffX = x - vector.x
		let diffY = y - vector.y
		let angle = atan2(Float(diffY), Float(diffX)) - .pi / 2
		return (angle + 2 * .pi).truncatingRemainder(dividingBy: 2 * .pi)
	}
}
