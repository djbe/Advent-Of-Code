//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private extension Program {
	mutating func set(noun: Int, verb: Int) {
		data[1] = noun
		data[2] = verb
	}
}

struct Day02: Day {
	static let name = "1202 Program Alarm"
	private var program: Program

	init(input: Input) {
		program = Program(code: input.lines)
	}
}

// MARK: - Part 1

extension Day02 {
	mutating func part1() -> Any {
		logPart("What value is left at position 0 after the program halts?")

		program.set(noun: 12, verb: 2)
		var computer = Computer(program)
		computer.run()

		return computer.firstMemoryByte
	}
}

// MARK: - Part 2

extension Day02 {
	mutating func testModification(noun: Int, verb: Int) -> Int {
		program.set(noun: noun, verb: verb)
		var computer = Computer(program)
		computer.run()
		return computer.firstMemoryByte
	}

	mutating func part2() -> Any {
		logPart("Find the input noun and verb that cause the program to produce the output 19690720. What is 100 * noun + verb?")

		return Array(0...99).combinations(ofCount: 2)
			.first { testModification(noun: $0[0], verb: $0[1]) == 19_690_720 }
			.map { 100 * $0[0] + $0[1] } ?? 0
	}
}
