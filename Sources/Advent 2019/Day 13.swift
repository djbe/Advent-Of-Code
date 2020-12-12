//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private struct Pixel {
	typealias Point = Vector2<Int>
	enum Tile: Int {
		case empty
		case wall
		case block
		case paddle
		case ball
	}

	let point: Point
	let tile: Tile

	init(_ data: ArraySlice<Int>) {
		point = Point(Array(data.prefix(2)))
		tile = Tile(rawValue: data.last ?? 0) ?? .empty
	}
}

private final class Arcade {
	private let program: Program
	private let output = BlockingChannel()
	private var ball: Pixel.Point?
	private var paddle: Pixel.Point?
	var nubmerOfBlocks: Int = 0
	var score: Int = 0

	init(program: Program) {
		self.program = program
	}

	func run() {
		let computer = Computer(
			program,
			input: CallbackChannel(generator: joystickGenerator),
			output: CallbackChannel(receiver: outputReceiver, chunkedBy: 3)
		)

		computer.run()
	}

	private func outputReceiver(chunk: [Int]) {
		if chunk.prefix(2) == [-1, 0] {
			score = chunk[2]
		} else {
			let pixel = Pixel(chunk[...])
			switch pixel.tile {
			case .ball: ball = pixel.point
			case .paddle: paddle = pixel.point
			case .block: nubmerOfBlocks += 1
			default: break
			}
		}
	}

	private func joystickGenerator() -> Int {
		if let ball = ball, let paddle = paddle {
			return max(min(ball.x - paddle.x, 1), -1)
		} else {
			return -1
		}
	}
}

struct Day13: Day {
	var name: String { "Care Package" }

	private lazy var program = Program(code: loadInputFile())
}

// MARK: - Part 1

extension Day13 {
	mutating func part1() {
		logPart("Start the game. How many block tiles are on the screen when the game exits?")

		let arcade = Arcade(program: program)
		arcade.run()
		log(.info, "# of blocks: \(arcade.nubmerOfBlocks)")
	}
}

// MARK: - Part 2

extension Day13 {
	mutating func part2() {
		logPart("Beat the game by breaking all the blocks. What is your score after the last block is broken?")

		// insert coin
		program.data[0] = 2

		// play
		let arcade = Arcade(program: program)
		arcade.run()
		log(.info, "Score: \(arcade.score)")
	}
}
