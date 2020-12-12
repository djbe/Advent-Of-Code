//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

final class Computer {
	private var memory: Memory
	private let input: Channel
	private var output: Channel

	init(_ program: Program, input: Channel = BlockingChannel(), output: Channel = BlockingChannel()) {
		memory = Memory(program: program)
		self.input = input
		self.output = output
	}

	func run() {
		while true {
			let instruction = memory.current
			instruction.execute(memory: memory, input: input, output: output)

			if instruction.opcode == .stop {
				return
			}
		}
	}
}

extension Computer {
	var firstMemoryByte: Int {
		memory.data.first ?? 0
	}

	func runAndWaitForOutput() -> Int {
		run()
		return output.receiveLast()
	}
}
