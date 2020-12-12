//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day09: Day {
	var name: String { "Sensor Boost" }

	private lazy var program = Program(code: loadInputFile())
}

// MARK: - Part 1

extension Day09 {
	mutating func part1() -> Any {
		logPart("What BOOST keycode does it produce?")

		let output = BlockingChannel()
		let computer = Computer(program, input: BlockingChannel(1), output: output)
		computer.run()

		return output.contents
	}
}

// MARK: - Part 2

extension Day09 {
	mutating func part2() -> Any {
		logPart("What are the coordinates of the distress signal?")

		let output = BlockingChannel()
		let computer = Computer(program, input: BlockingChannel(2), output: output)
		computer.run()

		return output.contents
	}
}
