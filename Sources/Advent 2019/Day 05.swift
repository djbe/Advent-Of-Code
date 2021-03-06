//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day05: Day {
	static let name = "Sunny with a Chance of Asteroids"
	private let program: Program

	init(input: Input) {
		program = Program(code: input.lines)
	}
}

// MARK: - Part 1

extension Day05 {
	mutating func part1() -> Any {
		logPart("After providing 1 to the only input instruction and passing all the tests, what diagnostic code does the program produce?")

		var computer = Computer(program, input: BlockingChannel(1))
		let result = computer.runAndWaitForOutput()

		return result
	}
}

// MARK: - Part 2

extension Day05 {
	mutating func part2() -> Any {
		logPart("What is the diagnostic code for system ID 5?")

		var computer = Computer(program, input: BlockingChannel(5))
		let result = computer.runAndWaitForOutput()

		return result
	}
}
