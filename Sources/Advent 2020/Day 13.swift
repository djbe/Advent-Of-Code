//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

struct Schedule {
	let now: Int
	let ids: [Int]
	let indices: [Int]

	init<T: StringProtocol>(lines: [T]) {
		let numbers = zip(0..., lines[1].split(separator: ",").map { Int(String($0)) })

		now = Int(lines[0]) ?? 0
		ids = numbers.compactMap(\.1)
		indices = numbers.filter { $0.1 != nil }.map(\.0)
	}
}

struct Day13: Day {
	var name: String { "Shuttle Search" }

	private lazy var schedule = Schedule(lines: loadInputFile())
}

// MARK: - Part 1

extension Schedule {
	func scheduleAfter(_ timestamp: Int) -> [(bus: Int, time: Int)] {
		let times = ids.map { timestamp.isMultiple(of: $0) ? timestamp : (((timestamp / $0) + 1) * $0) }
		return Array(zip(ids, times))
	}
}

extension Day13 {
	mutating func part1() -> Any {
		logPart("What is the ID of the earliest bus you can take to the airport multiplied by the number of minutes you'll need to wait for that bus?")

		let result = schedule.scheduleAfter(schedule.now).min { $0.time < $1.time } ?? (0, 0)

		return result.bus * (result.time - schedule.now)
	}
}

// MARK: - Part 2

extension Schedule {
	private typealias Bus = (offset: Int, multiplier: Int)

	var earliestIncreasingTime: Int {
		var interval = 1

		return zip(indices, ids).reduce(into: 0) { (timestamp: inout Int, bus: Bus) in
			// find the next time matching our bus' offset
			timestamp = stride(from: timestamp, to: Int.max, by: interval)
				.first { ($0 + bus.offset).isMultiple(of: bus.multiplier) } ?? 0

			// now only increase in intervals that match this bus (and all previous)
			interval *= bus.multiplier
		}
	}
}

extension Day13 {
	mutating func part2() -> Any {
		logPart("What is the earliest timestamp such that all of the listed bus IDs depart at offsets matching their positions in the list?")

		return schedule.earliestIncreasingTime
	}
}
