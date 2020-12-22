//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension FloatingPoint {
	static var tau: Self { 2 * pi }
}

public func deg2rad<T: BinaryInteger>(_ degrees: T) -> Float {
	deg2rad(Float(degrees))
}

public func deg2rad<T: FloatingPoint>(_ degrees: T) -> T {
	degrees * .pi / 180
}

public func rad2deg<T: FloatingPoint>(_ radians: T) -> T {
	radians * 180 / .pi
}
