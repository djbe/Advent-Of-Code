//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private struct Instruction {
	enum Operation: String {
		case acc, jmp, nop, unknown
	}

	let operation: Operation
	let argument: Int
}

extension Instruction {
	init<T: StringProtocol>(_ value: T) {
		operation = Operation(rawValue: String(value.split(separator: " ")[0])) ?? .unknown
		argument = Int(value.split(separator: " ")[1]) ?? 0
	}
}

extension Instruction {
	func execute(pointer: Int, accumulator: inout Int) -> Int {
		var newPointer = pointer + 1

		log(.debug, "\(pointer) \(operation) \(argument)")
		switch operation {
		case .acc: accumulator += argument
		case .jmp: newPointer = pointer + argument
		case .nop: break
		case .unknown: preconditionFailure("Uknown instruction!")
		}

		return newPointer
	}
}

private struct Program {
	let data: [Instruction]

	var size: Int {
		data.count
	}
}

extension Program {
	init<T: StringProtocol>(code: [T]) {
		data = code.map(Instruction.init)
	}
}

private final class Computer {
	private var program: Program
	private var pointer: Int
	private var accumulator: Int

	init(program: Program) {
		self.program = program
		pointer = 0
		accumulator = 0
	}
}

extension Computer {
	func debug() -> (finished: Bool, result: Int) {
		var alreadyExecuted: Set<Int> = []

		while !alreadyExecuted.contains(pointer), pointer < program.size {
			alreadyExecuted.insert(pointer)
			let instruction = program.data[pointer]
			pointer = instruction.execute(pointer: pointer, accumulator: &accumulator)
		}

		return (pointer >= program.size, accumulator)
	}
}

struct Day08: Day {
	var name: String { "Handheld Halting" }

	private lazy var program = Program(code: loadInputFile())
}

// MARK: - Part 1

extension Day08 {
	mutating func part1() {
		logPart("Immediately before any instruction is executed a second time, what value is in the accumulator?")

		let computer = Computer(program: program)
		let result = computer.debug()
		log(.info, "Result after debugging: \(result.result)")
	}
}

// MARK: - Part 2

extension Program {
	func isInstructionTweakable(at index: Int) -> Bool {
		data[index].operation == .jmp || data[index].operation == .nop
	}

	func tweakingInstruction(at index: Int) -> Program {
		var data = self.data
		switch data[index].operation {
		case .jmp: data[index] = Instruction(operation: .nop, argument: data[index].argument)
		case .nop: data[index] = Instruction(operation: .jmp, argument: data[index].argument)
		default: break
		}
		return Program(data: data)
	}
}

extension Day08 {
	mutating func part2() {
		logPart("What is the value of the accumulator after the program terminates?")

		let program = self.program
		let result = (0..<program.size)
			.filter(program.isInstructionTweakable(at:))
			.lazy.map { (index: Int) -> (finished: Bool, result: Int) in
				let computer = Computer(program: program.tweakingInstruction(at: index))
				return computer.debug()
			}
			.first { $0.finished }

		log(.info, "Result after debugging: \(result?.result ?? .min)")
	}
}
