import Foundation

/// Allow for easier loading of input files, which are always multiline text files
public func loadInputFile(_ name: String, separator: Character = "\n", omittingEmptySubsequences: Bool = true) -> [String.SubSequence] {
	let path = Bundle.main.path(forResource: "input", ofType: "txt")!
	return try! String(contentsOfFile: path).split(separator: separator, omittingEmptySubsequences: omittingEmptySubsequences)
}
