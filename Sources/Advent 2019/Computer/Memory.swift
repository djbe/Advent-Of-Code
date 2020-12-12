//
// Advent
// Copyright © 2020 David Jennes
//

import Common
import Foundation

final class Memory {
	var data: [Int]
	var extraMemory: [Int: Int]
	var pointer: Int
	var relativeBase: Int

	init(program: Program) {
		data = program.data
		extraMemory = [:]
		pointer = 0
		relativeBase = 0
	}
}

extension Memory {
	var current: Instruction {
		Instruction(data[pointer])
	}

	subscript(_ pointer: Int, offset: Int, modes: [Instruction.Mode] = []) -> Int {
		get {
			let address: Int

			switch (offset <= modes.count) ? modes[offset - 1] : .position {
			case .immediate:
				address = pointer + offset
				log(.trace, "- Read-\(offset): \(self[address])")
			case .position:
				address = data[pointer + offset]
				log(.trace, "- Read-\(offset) at \(address): \(self[address])")
			case .relative:
				address = relativeBase + data[pointer + offset]
				log(.trace, "- Read-\(offset) at \(address) (b\(relativeBase) + \(data[pointer + offset])): \(self[address])")
			}

			return self[address]
		}
		set {
			let address: Int
			switch (offset <= modes.count) ? modes[offset - 1] : .position {
			case .immediate:
				preconditionFailure("Writes may NOT use immediate mode")
			case .position:
				address = data[pointer + offset]
				log(.trace, "- Write-\(offset) at \(address) := \(newValue)")
			case .relative:
				address = relativeBase + data[pointer + offset]
				log(.trace, "- Write-\(offset) at \(address) (b\(relativeBase) + \(data[pointer + offset])) := \(newValue)")
			}

			self[address] = newValue
		}
	}

	private subscript(address: Int) -> Int {
		get {
			address < data.count ? data[address] : extraMemory[address, default: 0]
		}
		set {
			if address < data.count {
				data[address] = newValue
			} else {
				extraMemory[address] = newValue
			}
		}
	}
}
