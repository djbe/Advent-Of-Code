//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

struct Day17: Day {
	static let name = "Set and Forget"
	private var program: Program
	private var video = false

	init(input: Input) {
		program = Program(code: input.lines)
	}
}

// MARK: - Part 1

extension Day17 {
	static let directions: [Matrix.Point] = [[0, 1], [0, -1], [-1, 0], [1, 0]].map(Matrix.Point.init)

	func adjacent(to point: Matrix<Bool>.Point) -> [Matrix<Bool>.Point] {
		Self.directions.map { point + $0 }
	}

	mutating func part1() -> Any {
		logPart("Run your ASCII program. What is the sum of the alignment parameters for the scaffold intersections?")

		var computer = Computer(program)
		computer.run()

		let output = Input(String(computer.output.contents.compactMap(Character.init(ascii:))))
		let grid = Matrix<Bool>(output.lines)
		let intersections = grid.filter { grid[$0] && adjacent(to: $0).allSatisfy { grid.get($0) == true } }

		return intersections.map { $0.x * $0.y }.reduce(0, +)
	}
}

// MARK: - Part 2

extension Day17 {
	mutating func part2() -> Any {
		logPart("After visiting every part of the scaffold at least once, how much dust does the vacuum robot report it has collected?")

		let instructions = """
		A,A,B,C,B,C,B,C,A,C
		R,6,L,8,R,8
		R,4,R,6,R,6,R,4,R,4
		L,8,R,6,L,10,L,10
		\(video ? "y" : "n")

		""".compactMap(\.asciiValue).map(Int.init)

		program.data[0] = 2
		var computer = Computer(program, input: BlockingChannel(data: instructions))
		let result = computer.runAndWaitForOutput()

		return result
	}
}
