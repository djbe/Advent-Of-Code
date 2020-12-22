//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private protocol Computer {
	var memory: [Int: Int] { get }
	mutating func execute(instructions: [Instruction])
}

extension Computer {
	var memorySum: Int {
		memory.values.sum
	}
}

private enum Instruction {
	case setMask(String)
	case write(address: Int, value: Int)

	init<T: StringProtocol>(_ value: T) {
		let comps = value.components(separatedBy: " = ")
		if comps[0] == "mask" {
			self = .setMask(comps[1])
		} else {
			self = .write(
				address: Int(comps[0].dropFirst(4).dropLast()) ?? 0,
				value: Int(comps[1]) ?? 0
			)
		}
	}
}

struct Day14: Day {
	var name: String { "Docking Data" }

	private lazy var program: [Instruction] = loadInputFile().map(Instruction.init)
}

// MARK: - Part 1

private struct ComputerV1: Computer {
	fileprivate var memory: [Int: Int] = [:]
	private var mask: Int = 0
	private var overwriteBits: Int = 0

	mutating func execute(instructions: [Instruction]) {
		for instruction in instructions {
			switch instruction {
			case .setMask(let string):
				mask = Int(String(string.map { $0 == "X" ? "1" : "0" }), radix: 2) ?? 0
				overwriteBits = Int(String(string.map { $0 == "X" ? "0" : $0 }), radix: 2) ?? 0
			case .write(let address, let value):
				memory[address] = (value & mask) | overwriteBits
			}
		}
	}
}

extension Day14 {
	mutating func part1() -> Any {
		logPart("Execute the initialization program. What is the sum of all values left in memory after it completes?")

		var computer = ComputerV1()
		computer.execute(instructions: program)

		return computer.memorySum
	}
}

// MARK: - Part 2

private struct ComputerV2: Computer {
	fileprivate var memory: [Int: Int] = [:]
	private var mask: Int = 0
	private var addressVariations: [Int] = []

	mutating func execute(instructions: [Instruction]) {
		for instruction in instructions {
			switch instruction {
			case .setMask(let string):
				mask = Int(String(string.map { $0 == "0" ? "1" : "0" }), radix: 2) ?? 0
				addressVariations = Self.variations(for: string)
			case .write(let address, let value):
				for variation in addressVariations {
					memory[(address & mask) | variation] = value
				}
			}
		}
	}

	private static func variations(for template: String) -> [Int] {
		let base = Int(String(template.map { $0 == "1" ? "1" : "0" }), radix: 2) ?? 0
		let bits = zip(0..., template.reversed()).filter { $1 == "X" }.map(\.0)

		// all possibilities for each `X` bit
		return (0..<(1 << bits.count)).map { template in
			zip(0..., bits).reduce(base) { result, bit in
				result | ((template & (1 << bit.0)) << (bit.1 - bit.0))
			}
		}
	}
}

extension Day14 {
	mutating func part2() -> Any {
		logPart("Execute the initialization program using an emulator for a version 2 decoder chip. What is the sum of all values left in memory after it completes?")

		var computer = ComputerV2()
		computer.execute(instructions: program)

		return computer.memorySum
	}
}
