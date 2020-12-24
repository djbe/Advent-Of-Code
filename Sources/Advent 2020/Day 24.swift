//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private struct Lobby {
	typealias Point = Vector2<Int>
	var blackTiles: Set<Point> = []
}

private extension Lobby.Point {
	// use horizontally "doubled" coordinates
	// see https://www.redblobgames.com/grids/hexagons/
	var isOnHexGrid: Bool {
		(x + y).isMultiple(of: 2)
	}
}

extension Lobby {
	enum Instruction: String, CaseIterable {
		case east = "e"
		case southEast = "se"
		case southWest = "sw"
		case west = "w"
		case northWest = "nw"
		case northEast = "ne"

		init?<T: StringProtocol>(_ value: T) {
			if value.first == "e" {
				self = .east
			} else if value.first == "w" {
				self = .west
			} else {
				self.init(rawValue: String(value))
			}
		}

		static let directions: [Instruction: Point] = [
			.east: [2, 0], .southEast: [1, 1], .southWest: [-1, 1],
			.west: [-2, 0], .northWest: [-1, -1], .northEast: [1, -1]
		]
		var direction: Point {
			Self.directions[self, default: [0, 0]]
		}
	}
}

extension Lobby: CustomStringConvertible {
	var description: String {
		blackTiles.descriptionMapping {
			guard $0.isOnHexGrid else { return " " }
			return blackTiles.contains($0) ? "X" : "."
		}
	}
}

struct Day24: Day {
	static let name = "Lobby Layout"
	private let lines: [Line<Substring>]
	private var lobby = Lobby()

	init(input: Input) {
		lines = input.lines
	}
}

// MARK: - Part 1

extension Lobby {
	mutating func flipTile<T: StringProtocol>(at line: Line<T>) {
		var current: Point = .zero
		var instructions = line.raw[...]

		while !instructions.isEmpty {
			guard let instruction = Instruction(instructions.prefix(2)) else {
				fatalError("Unknown instruction \(instructions.prefix(2))")
			}
			current += instruction.direction
			instructions = instructions.dropFirst(instruction.rawValue.count)
		}

		if blackTiles.contains(current) {
			blackTiles.remove(current)
		} else {
			blackTiles.insert(current)
		}
	}
}

extension Day24 {
	mutating func part1() -> Any {
		logPart("Go through the renovation crew's list and determine which tiles they need to flip. After all of the instructions have been followed, how many tiles are left with the black side up?")

		for line in lines {
			lobby.flipTile(at: line)
		}

		return lobby.blackTiles.count
	}
}

// MARK: - Part 2

extension Lobby {
	mutating func step() {
		var result = blackTiles

		for point in blackTiles.surroundingGrid(margin: 2) where point.isOnHexGrid {
			let tileCount = blackTiles(surrounding: point)
			if blackTiles.contains(point), !(1...2).contains(tileCount) {
				result.remove(point)
			} else if !blackTiles.contains(point), tileCount == 2 {
				result.insert(point)
			}
		}

		blackTiles = result
	}

	private func blackTiles(surrounding point: Point) -> Int {
		let adjacent = Instruction.directions.values.map { point + $0 }
		return blackTiles.intersection(adjacent).count
	}
}

extension Day24 {
	mutating func part2() -> Any {
		logPart("How many tiles will be black after 100 days?")

		for _ in 1...100 {
			lobby.step()
		}

		return lobby.blackTiles.count
	}
}
