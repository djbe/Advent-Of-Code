import Foundation

public protocol VectorType: Hashable, ExpressibleByArrayLiteral, CustomStringConvertible {
	associatedtype Real: Numeric

	init(_ coordinates: [Real])
	init(_ coordinates: Real...)

	var coordinates: [Real] { get }
}

// MARK: - Default implementation

public extension VectorType {
	init(_ elements: Real...) {
		self.init(elements)
	}

	init(arrayLiteral elements: Real...) {
		self.init(elements)
	}

	func scale(value: Real) -> Self {
		Self(coordinates.map { $0 * value })
	}

	var squareLength: Real {
		self.dotProduct(vector: self)
	}

	func dotProduct(vector: Self) -> Real {
		zip(coordinates, vector.coordinates).reduce(0) { sumOfProducts, item in
			sumOfProducts + item.0 * item.1
		}
	}

	func squareDistanceTo(vector: Self) -> Real {
		(self - vector).squareLength
	}
}

public extension VectorType where Real: FloatingPoint {
	var length: Real {
		norm
	}

	var norm: Real {
		sqrt(squareLength)
	}

	func unit() -> Self {
		scale(value: 1 / length)
	}

	func distanceTo(vector: Self) -> Real {
		(self - vector).length
	}
}

public extension VectorType where Real: BinaryInteger {
	var length: Float {
		norm
	}

	var norm: Float {
		sqrt(Float(squareLength))
	}

	func scale(value: Float) -> Self {
		Self(coordinates.map { Real(Float($0) * value) })
	}

	func unit() -> Self {
		scale(value: 1 / Float(length))
	}

	func distanceTo(vector: Self) -> Float {
		(self - vector).length
	}
}

// MARK: - Operators

public extension VectorType {
	static func + (v1: Self, v2: Self) -> Self {
		zipAndCombine(v1, v2, -)
	}

	static func - (v1: Self, v2: Self) -> Self {
		zipAndCombine(v1, v2, -)
	}

	static func * (scalar: Real, vector: Self) -> Self {
		vector.scale(value: scalar)
	}

	static func * (vector: Self, scalar: Real) -> Self {
		scalar * vector
	}

	static func * (v1: Self, v2: Self) -> Real {
		v1.dotProduct(vector: v2)
	}
}

public extension VectorType where Real: FloatingPoint {
	static func / (vector: Self, scalar: Real) -> Self {
		vector.scale(value: 1 / scalar)
	}
}

public extension VectorType where Real: BinaryInteger {
	static func / (vector: Self, scalar: Real) -> Self {
		vector.scale(value: 1 / Float(scalar))
	}
}

public extension VectorType where Real: SignedNumeric {
	static prefix func - (vector: Self) -> Self where Real: SignedNumeric {
		Self(vector.coordinates.map(-))
	}
}

// MARK: - Helpers

public extension VectorType {
	var description: String {
		"(\(coordinates.map({ String(describing: $0) }).joined(separator: ", ")))"
	}
}

private extension VectorType {
	static func zipAndCombine(_ v1: Self, _ v2: Self, _ op: (Real, Real) -> Real) -> Self {
		Self(zip(v1.coordinates, v2.coordinates).map(op))
	}
}
