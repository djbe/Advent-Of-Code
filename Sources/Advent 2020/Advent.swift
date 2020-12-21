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

public struct Advent2020: ParsableCommand {
	public static let configuration = CommandConfiguration(commandName: "2020", abstract: "Advent 2020", subcommands: [
		Day01.self, Day02.self, Day03.self, Day04.self, Day05.self,
		Day06.self, Day07.self, Day08.self, Day09.self, Day10.self,
		Day11.self, Day12.self, Day13.self, Day14.self, Day15.self,
		Day16.self, Day17.self, Day18.self, Day19.self, Day20.self,
		Day21.self
	])

	public init() {}

	public func run() throws {
		guard var day = Self.configuration.subcommands.last?.init() else { return }
		try day.run()
	}
}
