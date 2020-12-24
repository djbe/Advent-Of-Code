//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
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

public extension CharacterSet {
	static let comma = CharacterSet(charactersIn: ",")
}

public final class Input {
	public let raw: String

	public init(_ raw: String) {
		self.raw = raw.trimmingCharacters(in: .newlines)
	}

	public convenience init(file: String, in bundle: Bundle) {
		if let url = bundle.url(forResource: file, withExtension: "txt"),
		   let contents = try? String(contentsOf: url) {
			self.init(contents)
		} else {
			preconditionFailure("Unable to load file \(file).txt")
		}
	}

	public lazy var integer: Int? = Int(raw)
	public lazy var characters: [Character] = Array(raw)
	public lazy var trimmed = Input(raw.trimmingCharacters(in: .whitespacesAndNewlines))
	public lazy var sections: [[Line]] = self.sections()
	public lazy var lines: [Line] = raw.split(separator: "\n", omittingEmptySubsequences: false).map(Line.init)
	public lazy var words: [Word] = self.words(separatedBy: .whitespaces)
	public lazy var csvWords: [Word] = self.words(separatedBy: .comma)
	public lazy var csvIntegers: [Int] = csvWords.compactMap(\.integer)
	public lazy var rawLines: [String.SubSequence] = lines.map(\.raw)

	public func sections(separatedBy: String = "\n\n") -> [[Line<Substring>]] {
		raw.components(separatedBy: "\n\n").map { section in section.split(separator: "\n").map(Line.init) }
	}

	public func words(separatedBy: CharacterSet) -> [Word] {
		raw.components(separatedBy: separatedBy).filter { !$0.isEmpty }.map(Word.init)
	}

	public func words(separatedBy: String) -> [Word] {
		raw.components(separatedBy: separatedBy).filter { !$0.isEmpty }.map(Word.init)
	}
}

public final class Line<T: StringProtocol> {
	public let raw: T

	public init(_ raw: T) {
		self.raw = raw
	}

	public lazy var integer: Int? = Int(raw)
	public lazy var characters: [Character] = Array(raw)
	public lazy var trimmed: Line<String> = .init(raw.trimmingCharacters(in: .whitespacesAndNewlines))
	public lazy var words: [Word] = self.words(separatedBy: .whitespaces)
	public lazy var csvWords: [Word] = self.words(separatedBy: .comma)
	public lazy var csvIntegers: [Int] = csvWords.compactMap(\.integer)
	public lazy var rawWords: [String] = words.map(\.raw)

	public func words(separatedBy: CharacterSet) -> [Word] {
		raw.components(separatedBy: separatedBy).filter { !$0.isEmpty }.map(Word.init)
	}

	public func words(separatedBy: String) -> [Word] {
		raw.components(separatedBy: separatedBy).filter { !$0.isEmpty }.map(Word.init)
	}
}

public final class Word {
	public let raw: String

	public init(_ raw: String) {
		self.raw = raw
	}

	public lazy var integer: Int? = Int(raw)
	public lazy var characters: [Character] = Array(raw)
	public lazy var trimmed = Word(raw.trimmingCharacters(in: .whitespacesAndNewlines))
}
