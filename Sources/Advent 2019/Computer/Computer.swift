//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

struct Computer {
	private var memory: Memory
	var input: Channel
	var output: Channel

	init(_ program: Program, input: Channel = BlockingChannel(), output: Channel = BlockingChannel()) {
		memory = Memory(program: program)
		self.input = input
		self.output = output
	}

	mutating func run() {
		while true {
			let instruction = memory.current
			instruction.execute(memory: &memory, input: input, output: output)

			if instruction.opcode == .stop {
				return
			}
		}
	}

	mutating func runUntilOutput() -> Int {
		while true {
			let instruction = memory.current
			instruction.execute(memory: &memory, input: input, output: output)

			if instruction.opcode == .stop {
				return 0
			} else if instruction.opcode == .read {
				return output.receive()
			}
		}
	}
}

extension Computer {
	var firstMemoryByte: Int {
		memory.data.first ?? 0
	}

	mutating func runAndWaitForOutput() -> Int {
		run()
		return output.receiveLast()
	}
}
