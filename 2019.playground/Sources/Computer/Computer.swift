import Foundation

public class Computer {
	private var memory: Memory
	private let input: Channel<Int>
	private var output: Channel<Int>

	public init(_ program: Program, input: Channel<Int> = Channel(), output: Channel<Int> = Channel()) {
		memory = Memory(program: program)
		self.input = input
		self.output = output
	}

	public func run() {
		while true {
			let instruction = memory.current
			instruction.execute(memory: memory, input: input, output: output)

			if instruction.opcode == .stop {
				return
			}
		}
	}

	public var firstMemoryByte: Int {
		memory.data.first ?? 0
	}
}

extension Computer {
	public func runAndWaitForOutput() -> Int {
		run()
		return output.receiveLast()
	}
}
