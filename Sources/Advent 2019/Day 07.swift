import Algorithms
import Common
import Foundation

private struct Circuit {
	private let computers: [Computer]
	private let channels: [Channel<Int>]
	private let outputChannel: Channel<Int>

	func run(start: Int = 0) -> Int {
		let group = DispatchGroup()

		computers.forEach { computer in
			group.enter()
			DispatchQueue.global().async {
				computer.run()
				group.leave()
			}
		}
		channels[0].send(start)

		group.wait()
		return outputChannel.receiveLast()
	}
}

struct Day07: Day {
	var name: String { "Amplification Circuit" }

	private lazy var program = Program(code: loadInputFile())
}

// MARK: - Part 1

extension Circuit {
	static func makeSequence(program: Program, settings: [Int]) -> Circuit {
		let channels = settings.map { Channel($0) } + [Channel()]
		let computers = zip(channels, channels.dropFirst()).map { input, output in
			Computer(program, input: input, output: output)
		}
		return Circuit(computers: computers, channels: channels, outputChannel: channels[channels.count - 1])
	}
}

extension Day07 {
	mutating func part1() {
		logPart("What is the highest signal that can be sent to the thrusters?")

		let circuits: [Circuit] = (0...4).map { $0 }.permutations()
			.map { Circuit.makeSequence(program: program, settings: $0) }

		let result = circuits.map { $0.run() }.max() ?? 0
		log(.info, "Max thruster signal: \(result)")
	}
}

// MARK: - Part 2

extension Circuit {
	static func makeLoop(program: Program, settings: [Int]) -> Circuit {
		let channels = settings.map { Channel($0) }
		let computers = zip(0..., channels).map { index, input in
			Computer(program, input: input, output: channels[(index + 1) % channels.count])
		}
		return Circuit(computers: computers, channels: channels, outputChannel: channels[0])
	}
}

extension Day07 {
	mutating func part2() {
		logPart("What is the highest signal that can be sent to the thrusters?")

		let circuits: [Circuit] = (5...9).map { $0 }.permutations()
			.map { Circuit.makeLoop(program: program, settings: $0) }

		let result = circuits.map { $0.run() }.max() ?? 0
		log(.info, "Max thruster signal with feedback: \(result)")
	}
}
