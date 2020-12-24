//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private final class Circuit {
	private var computers: [Computer]
	private let channels: [BlockingChannel]
	private let outputChannel: BlockingChannel

	init(computers: [Computer], channels: [BlockingChannel], outputChannel: BlockingChannel) {
		self.computers = computers
		self.channels = channels
		self.outputChannel = outputChannel
	}

	func run(start: Int = 0) -> Int {
		let group = DispatchGroup()

		(0..<computers.count).forEach { index in
			group.enter()
			DispatchQueue.global().async {
				self.computers[index].run()
				group.leave()
			}
		}
		channels[0].send(start)

		group.wait()
		return outputChannel.receiveLast()
	}
}

struct Day07: Day {
	static let name = "Amplification Circuit"
	private let program: Program

	init(input: Input) {
		program = Program(code: input.lines)
	}
}

// MARK: - Part 1

extension Circuit {
	static func makeSequence(program: Program, settings: [Int]) -> Circuit {
		let channels = settings.map { BlockingChannel($0) } + [BlockingChannel()]
		let computers = zip(channels, channels.dropFirst()).map { input, output in
			Computer(program, input: input, output: output)
		}
		return Circuit(computers: computers, channels: channels, outputChannel: channels[channels.count - 1])
	}
}

extension Day07 {
	mutating func part1() -> Any {
		logPart("What is the highest signal that can be sent to the thrusters?")

		let circuits: [Circuit] = Array(0...4).permutations()
			.map { Circuit.makeSequence(program: program, settings: $0) }

		return circuits.map { $0.run() }.max() ?? 0
	}
}

// MARK: - Part 2

extension Circuit {
	static func makeLoop(program: Program, settings: [Int]) -> Circuit {
		let channels = settings.map { BlockingChannel($0) }
		let computers = zip(0..., channels).map { index, input in
			Computer(program, input: input, output: channels[(index + 1) % channels.count])
		}
		return Circuit(computers: computers, channels: channels, outputChannel: channels[0])
	}
}

extension Day07 {
	mutating func part2() -> Any {
		logPart("What is the highest signal that can be sent to the thrusters?")

		let circuits: [Circuit] = Array(5...9).permutations()
			.map { Circuit.makeLoop(program: program, settings: $0) }

		return circuits.map { $0.run() }.max() ?? 0
	}
}
