//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

// swiftlint:disable identifier_name yoda_condition

public func gcd<T: BinaryInteger>(_ a: T, _ b: T) -> T {
	assert(a >= 0 && b >= 0)

	// Assuming gcd(0,0)=0:
	guard a != 0 else { return b }
	guard b != 0 else { return a }

	var a = a, b = b, n = Int()

	// Remove the largest 2ⁿ from them:
	while (a | b) & 1 == 0 { a >>= 1; b >>= 1; n += 1 }

	// Reduce `a` to odd value:
	while a & 1 == 0 { a >>= 1 }

	repeat {
		// Reduce `b` to odd value
		while b & 1 == 0 { b >>= 1 }

		// Both `a` & `b` are odd here (or zero maybe?)

		// Make sure `b` is greater
		if a > b { swap(&a, &b) }

		// Subtract smaller odd `a` from the bigger odd `b`,
		// which always gives a positive even number (or zero)
		b -= a

		// keep repeating this, until `b` reaches zero
	} while b != 0

	return a << n // 2ⁿ×a
}

public func gcd<T: BinaryInteger>(_ numbers: [T]) -> T {
	numbers.dropFirst().reduce(numbers.first ?? 0) { gcd($0, $1) }
}

public func lcm<T: BinaryInteger>(_ a: T, _ b: T) -> T {
	assert(a >= 0 && b >= 0)
	return a / gcd(a, b) * b
}

public func lcm<T: BinaryInteger>(_ numbers: [T]) -> T {
	numbers.dropFirst().reduce(numbers.first ?? 0) { lcm($0, $1) }
}
