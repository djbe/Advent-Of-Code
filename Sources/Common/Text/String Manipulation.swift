//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public extension StringProtocol {
	/// Easy access to character at offset
	subscript(offset: Int) -> Element {
		self[index(startIndex, offsetBy: offset)]
	}

	subscript(safe offset: Int) -> Element? {
		guard offset >= 0, offset < count else { return nil }
		return self[index(startIndex, offsetBy: offset)]
	}

	/// Replace all characters in the given set, with the given replacement string
	func replacingCharacters(from characterSet: CharacterSet, with replacement: String) -> String {
		components(separatedBy: characterSet).joined(separator: replacement)
	}
}
