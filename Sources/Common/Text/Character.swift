//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension Character {
	init?(ascii: Int) {
		guard let scalar = Unicode.Scalar(ascii) else { return nil }
		self.init(scalar)
	}
}
