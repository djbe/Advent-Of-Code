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
	var name: String { "1202 Program Alarm" }

	private lazy var program = Program(code: loadInputFile())
}

// MARK: - Part 1

extension Day02 {
	mutating func part1() {
		logPart("What value is left at position 0 after the program halts?")

		program.set(noun: 12, verb: 2)
		let computer = Computer(program)
		computer.run()

		log(.info, "Result after execution: \(computer.firstMemoryByte)")
	}
}

// MARK: - Part 2

extension Day02 {
	mutating func testModification(noun: Int, verb: Int) -> Int {
		program.set(noun: noun, verb: verb)
		let computer = Computer(program)
		computer.run()
		return computer.firstMemoryByte
	}

	mutating func part2() {
		logPart("What is 100 * noun + verb?")

		for choice in Array(0...99).combinations(ofCount: 2) {
			if testModification(noun: choice[0], verb: choice[1]) == 19_690_720 {
				let result = 100 * choice[0] + choice[1]
				log(.info, "Found combination: \(result)")
				break
			}
		}
	}
}
