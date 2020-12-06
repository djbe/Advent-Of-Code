import Foundation

/// Allow for easier loading of input files, which are always multiline text files
public func loadInputFile(_ name: String, separator: Character = "\n", omittingEmptySubsequences: Bool = true) -> [String.SubSequence] {
	let path = Bundle.main.path(forResource: "input", ofType: "txt")!
	return try! String(contentsOfFile: path).split(separator: separator, omittingEmptySubsequences: omittingEmptySubsequences)
}

extension StringProtocol {
	/// Easy access to character at offset
	public subscript(offset: Int) -> Element {
		self[index(startIndex, offsetBy: offset)]
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
