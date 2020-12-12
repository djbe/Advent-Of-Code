//
// Advent
// Copyright © 2020 David Jennes
//

import ArgumentParser
import Common
import Foundation

extension Day {
	func loadInputFile(separator: Character = "\n", omittingEmptySubsequences: Bool = true) -> [String.SubSequence] {
		Bundle.module.loadInputFile(String(describing: Self.self), separator: separator, omittingEmptySubsequences: omittingEmptySubsequences)
	}

	func loadTestFile(name: String, separator: Character = "\n", omittingEmptySubsequences: Bool = true) -> [String.SubSequence] {
		Bundle.module.loadInputFile("Test/\(Self.self)/\(name)", separator: separator, omittingEmptySubsequences: omittingEmptySubsequences)
	}
}

struct Advent: ParsableCommand {
	static let configuration = CommandConfiguration(abstract: "Advent 2019", subcommands: [
		Day01.self, Day02.self, Day03.self, Day04.self, Day05.self,
		Day06.self, Day07.self, Day08.self, Day09.self, Day10.self,
		Day11.self, Day12.self, Day13.self
	])

	func run() throws {
		guard var day = Self.configuration.subcommands.last?.init() else { return }
		try day.run()
	}
}

Advent.main()
