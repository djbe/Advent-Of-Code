import Foundation

public func gcd<T: BinaryInteger>(_ m: T, _ n: T) -> T {
	var a: T = 0
	var b = max(m, n)
	var r = min(m, n)

	while r != 0 {
		a = b
		b = r
		r = a % b
	}

	return b
}
