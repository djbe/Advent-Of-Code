//
// Advent
// Copyright © 2020 David Jennes
//

import ArgumentParser
import Common
import Foundation

public struct Advent2020: Advent {
	public static let bundle = Bundle.module
	public static let configuration = CommandConfiguration(commandName: "2020", abstract: "Advent 2020")
	public static let days: [Day.Type] = [
		Day01.self, Day02.self, Day03.self, Day04.self, Day05.self,
		Day06.self, Day07.self, Day08.self, Day09.self, Day10.self,
		Day11.self, Day12.self, Day13.self, Day14.self, Day15.self,
		Day16.self, Day17.self, Day18.self, Day19.self, Day20.self,
		Day21.self, Day22.self, Day23.self
	]

	@Argument public var day: Int = Self.days.count - 1

	public init() {}
}
