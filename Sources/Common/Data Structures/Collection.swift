//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension Sequence where Element: Numeric {
	var sum: Element {
		reduce(0, +)
	}

	var product: Element {
		reduce(1, *)
	}
}
