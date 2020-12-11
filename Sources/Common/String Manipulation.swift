import Foundation

extension StringProtocol {
	/// Easy access to character at offset
	public subscript(offset: Int) -> Element {
		self[index(startIndex, offsetBy: offset)]
	}

	public subscript(safe offset: Int) -> Element? {
		guard offset >= 0 && offset < count else { return nil }
		return self[index(startIndex, offsetBy: offset)]
	}

	/// Check if this string matches the given regular expression
	public func matches(regex: String) -> Bool {
		range(of: regex, options: .regularExpression) != nil
	}

	/// Replace all characters in the given set, with the given replacement string
	public func replacingCharacters(from characterSet: CharacterSet, with replacement: String) -> String {
		components(separatedBy: characterSet).joined(separator: replacement)
	}
}
