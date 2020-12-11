import Common
import Foundation

struct Instruction {
	enum Mode: Int {
		case position = 0, immediate, relative
	}

	enum Opcode: Int {
		case add = 1, multiply, write, read, jumpIfTrue, jumpIfFalse, lessThan, equals, adjustBase
		case stop = 99
	}

	let modes: [Mode]
	let opcode: Opcode

	init(_ value: Int) {
		guard let opcode = Opcode(rawValue: value % 100) else {
			preconditionFailure("Unknown opcode in \(value)")
		}
		self.opcode = opcode
		modes = [
			Mode(rawValue: value / 100 % 10) ?? .position,
			Mode(rawValue: value / 1000 % 10) ?? .position,
			Mode(rawValue: value / 10000 % 10) ?? .position
		]
	}

	var size: Int {
		switch opcode {
		case .add, .multiply, .lessThan, .equals: return 4
		case .jumpIfTrue, .jumpIfFalse: return 3
		case .read, .write, .adjustBase: return 2
		case .stop: return 1
		}
	}
}

extension Instruction {
	func execute(memory: Memory, input: Channel<Int>, output: Channel<Int>) {
		var pointer = memory.pointer

		log(.debug, "\(pointer) \(description(with: memory))")
		switch opcode {
		case .add:
			memory[pointer, 3, modes] = memory[pointer, 1, modes] + memory[pointer, 2, modes]
		case .multiply:
			memory[pointer, 3, modes] = memory[pointer, 1, modes] * memory[pointer, 2, modes]
		case .read:
			let value = memory[pointer, 1, modes]
			output.send(value)
		case .write:
			guard let value = input.receive() else { fatalError("No value in input channel!") }
			memory[pointer, 1, modes] = value
		case .jumpIfTrue:
			if memory[pointer, 1, modes] != 0 {
				pointer = memory[pointer, 2, modes]
				log(.debug, "=> Jumping to \(pointer)")
			}
		case .jumpIfFalse:
			if memory[pointer, 1, modes] == 0 {
				pointer = memory[pointer, 2, modes]
				log(.debug, "=> Jumping to \(pointer)")
			}
		case .lessThan:
			memory[pointer, 3, modes] = (memory[pointer, 1, modes] < memory[pointer, 2, modes]) ? 1 : 0
		case .equals:
			memory[pointer, 3, modes] = (memory[pointer, 1, modes] == memory[pointer, 2, modes]) ? 1 : 0
		case .adjustBase:
			memory.relativeBase += memory[pointer, 1, modes]
			log(.debug, "=> Base set to \(memory.relativeBase)")
		case .stop:
			break
		}

		if pointer == memory.pointer {
			pointer += size
		}
		memory.pointer = pointer
	}
}

// MARK: Logging

extension Instruction.Mode {
	var debugDescription: String {
		switch self {
		case .immediate: return "i"
		case .position: return "p"
		case .relative: return "r"
		}
	}
}

extension Instruction {
	func description(with memory: Memory) -> String {
		let params = zip(memory.data.dropFirst(memory.pointer + 1).prefix(size - 1), modes).map { "\($0)\($1.debugDescription)" }.joined(separator: " ")
		return "\(opcode) \(params)"
	}
}
