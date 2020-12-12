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
		guard var year = Self.configuration.subcommands.last?.init() else { return }
		try year.run()
	}
}

Advent.main()
