//
// Advent
// Copyright © 2020 David Jennes
//

import Advent_2019
import Advent_2020
import ArgumentParser

struct Advent: ParsableCommand {
	static let configuration = CommandConfiguration(abstract: "Advent", subcommands: [
		Advent2019.self, Advent2020.self
	])

	func run() throws {
		guard let yearType = Self.configuration.subcommands.last else { return }
		var year = yearType.parseOrExit()
		try year.run()
	}
}

Advent.main()
