//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension FixedWidthInteger {
	var onesDigit: Self.Magnitude {
		magnitude % 10
	}

	var digits: [Self] {
		var result = [Self]()
		var remainder = self >= 0 ? self : self * -1

		while remainder > 0 {
			let digit = remainder % 10
			result.append(digit)
			remainder /= 10
		}

		return Array(result.reversed())
	}

	var bits: [Bool] {
		(0..<Self.bitWidth).map { (self & (1 << $0)) > 0 }.reversed()
	}
}

public extension Int {
	init<C: Collection>(bits: C) where C.Element == Bool {
		self = bits.reduce(0) { $0 * 2 + ($1 ? 1 : 0) }
	}

	init<C: Collection>(digits: C) where C.Element == Int {
		self = zip(0..., digits.reversed()).reduce(0) { sum, digit in
			sum + abs(digit.1) * Int(pow(10, Double(digit.0)))
		}
	}
}
