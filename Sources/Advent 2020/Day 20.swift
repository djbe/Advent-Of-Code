//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private enum Direction: Int {
	case top, bottom, left, right
}

private struct Tile {
	let identifier: Int
	var edges: [[Bool]] = []
	var grid: Grid<Bool> {
		didSet { calculateEdges() }
	}

	init<T: StringProtocol>(_ lines: ArraySlice<T>) {
		let cleaned = lines.filter { !$0.isEmpty }
		identifier = Int(String(cleaned[0].dropFirst(5).dropLast())) ?? 0
		grid = Grid(lines: cleaned.dropFirst())
		calculateEdges()
	}

	private mutating func calculateEdges() {
		edges = [
			grid.data.first ?? [], grid.data.last ?? [],
			grid.data.compactMap(\.first), grid.data.compactMap(\.last)
		]
	}

	var possibleEdges: Set<[Bool]> {
		Set(edges + edges.map { $0.reversed() })
	}

	func numberOfCommonEdges(to tile: Tile) -> Int {
		Set(edges).intersection(tile.possibleEdges).count
	}

	func edge(at direction: Direction) -> [Bool] {
		edges[direction.rawValue]
	}
}

extension Tile: Hashable {
	static func == (lhs: Tile, rhs: Tile) -> Bool {
		lhs.identifier == rhs.identifier
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
}

private final class Puzzle {
	let tiles: Set<Tile>

	init<T: StringProtocol>(_ input: [T]) {
		tiles = Set(input.chunked { !$1.isEmpty }.dropLast().map(Tile.init))
	}

	var corners: [Tile] {
		tiles.filter { tile in
			let possibilities = tiles.subtracting([tile]).filter { $0.numberOfCommonEdges(to: tile) > 0 }.count
			return possibilities == 2
		}
	}
}

struct Day20: Day {
	var name: String { "Jurassic Jigsaw" }

	private lazy var puzzle = Puzzle(loadInputFile(omittingEmptySubsequences: false))
}

// MARK: - Part 1

extension Day20 {
	mutating func part1() -> Any {
		logPart("Assemble the tiles into an image. What do you get if you multiply together the IDs of the four corner tiles?")

		return puzzle.corners.map(\.identifier).reduce(1, *)
	}
}

// MARK: - Part 2

extension Tile {
	// swiftlint:disable:next discouraged_optional_collection
	func fitted(top: [Bool]?, left: [Bool]?) -> Tile? {
		guard possibleEdges.isSuperset(of: [top, left].compactMap { $0 }) else { return nil }

		let edge = top ?? left
		let direction: Direction = top != nil ? .top : .left

		// try to match first edge
		var result = self
		let matched = grid.tryToFit { grid in
			result.grid = grid
			return result.edge(at: direction) == edge
		}

		// check the other edge
		guard matched else { return nil }
		if let left = left, top != nil {
			return result.edge(at: .left) == left ? result : nil
		} else {
			return result
		}
	}
}

extension Puzzle {
	func positionTopLeftCorner() -> Tile {
		var topLeft = corners[0]
		let other = tiles.subtracting([topLeft])

		// find conecting edges
		var cornerEdges = Set(topLeft.edges.filter { edge in
			other.contains { $0.possibleEdges.contains(edge) }
		})
		cornerEdges.formUnion(cornerEdges.map { $0.reversed() })

		// rotate topleft piece until its connecting edges face right/down
		while !cornerEdges.isSuperset(of: [topLeft.edge(at: .right), topLeft.edge(at: .bottom)]) {
			topLeft.grid.rotate()
		}

		return topLeft
	}

	func solve() -> Grid<Bool> {
		let topLeft = positionTopLeftCorner()
		var remaining = tiles.subtracting([topLeft])

		// position each tile (next to existing ones)
		var solution: [Grid.Point: Tile] = [Grid.Point(0, 0): topLeft]
		var position: Grid.Point = [1, 0]
		while !remaining.isEmpty {
			let topEdge = solution[position + [0, -1]]?.edge(at: .bottom)
			let leftEdge = solution[position + [-1, 0]]?.edge(at: .right)
			assert(topEdge != nil || leftEdge != nil, "Must connect to other piece(s)")

			if let tile = remaining.lazy.compactMap({ $0.fitted(top: topEdge, left: leftEdge) }).first {
				solution[position] = tile
				remaining.remove(tile)
				position += [1, 0]
			} else {
				position = [0, position.y + 1]
			}
		}

		// flatten tiles into grid (removing their borders)
		var result: [[Bool]] = []
		for row in 0...position.y {
			let rowTiles = (0...position.x).compactMap { solution[[$0, row]] }
			for tileRow in 1..<(rowTiles[0].grid.data.count - 1) {
				result.append(rowTiles.flatMap { $0.grid.data[tileRow].dropFirst().dropLast() })
			}
		}

		return Grid(result)
	}
}

private extension Grid where T == Bool {
	func count(monster: Grid<T>) -> Int {
		slidingWindow(size: monster.size)
			.map { _, mapSlice in
				let matches = zip(monster.data, mapSlice).allSatisfy { monster, map in
					zip(monster, map).allSatisfy { ($0 && $1) || !$0 }
				}
				return matches ? 1 : 0
			}
			.reduce(0, +)
	}
}

extension Day20 {
	static let monster = Grid(lines: """
	..................#.
	#....##....##....###
	.#..#..#..#..#..#...
	""".split(separator: "\n"))

	mutating func part2() -> Any {
		logPart("How many # are not part of a sea monster?")

		let result = puzzle.solve()

		// search for # monsters in grid
		var monsters = 0
		_ = result.tryToFit { grid in
			monsters = grid.count(monster: Self.monster)
			return monsters > 0
		}

		// calculate remaining tiles
		let monsterTiles = Self.monster.data.flatMap { $0 }.filter { $0 }.count
		let gridTiles = result.data.flatMap { $0 }.filter { $0 }.count

		return gridTiles - (monsterTiles * monsters)
	}
}
