//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private struct Map {
	private let map: [String: [String]]

	init<T: StringProtocol>(_ data: [T]) {
		let orbits = data.map { $0.components(separatedBy: ")") }.map { ($0[0], [$0[1]]) }
		map = Dictionary(orbits) { $0 + $1 }
	}

	subscript(key: String) -> [String] {
		map[key, default: []]
	}
}

struct Day06: Day {
	var name: String { "Universal Orbit Map" }

	private lazy var map = Map(loadInputFile())
}

// MARK: - Part 1

extension Map {
	func checksum(from start: String = "COM", depth: Int = 1) -> Int {
		self[start].count * depth +
			self[start].map { checksum(from: $0, depth: depth + 1) }.sum
	}
}

extension Day06 {
	mutating func part1() -> Any {
		logPart("What is the total number of direct and indirect orbits in your map data?")

		return map.checksum()
	}
}

// MARK: - Part 2

extension Map {
	func path(to end: String) -> [String] {
		path(from: "COM", to: end)
	}

	func path(from start: String, to end: String) -> [String] {
		if let endParent = map.first(where: { $0.value.contains(end) })?.key {
			return path(from: start, to: endParent) + [endParent]
		} else {
			return []
		}
	}

	func transfers(from start: String, to end: String) -> Int {
		let lhs = path(to: start)
		let rhs = path(to: end)

		let firstDifferent = (Array(zip(lhs, rhs)).firstIndex { $0 != $1 } ?? 0)
		return (lhs.count - firstDifferent) + (rhs.count - firstDifferent)
	}
}

extension Day06 {
	mutating func part2() -> Any {
		logPart("What is the minimum number of orbital transfers required to move from the object YOU are orbiting to the object SAN is orbiting?")

		return map.transfers(from: "YOU", to: "SAN")
	}
}
