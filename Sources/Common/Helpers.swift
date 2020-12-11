import ArgumentParser
import Foundation

public extension Bundle {
	/// Allow for easier loading of input files, which are always multiline text files
	func loadInputFile(_ name: String, separator: Character = "\n", omittingEmptySubsequences: Bool = true) -> [String.SubSequence] {
		guard let url = url(forResource: name, withExtension: "txt"),
			  let contents = try? String(contentsOf: url) else { return [] }
		return contents.split(separator: separator, omittingEmptySubsequences: omittingEmptySubsequences)
	}
}
