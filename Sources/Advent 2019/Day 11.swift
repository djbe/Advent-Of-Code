//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private final class Panel {
	typealias Point = Vector2<Int>

	var data: Matrix<Bool>
	var modifiedPositions: Set<Point> = []

	init(centeredAround point: Point) {
		let width = point.x * 2 + 2
		let height = point.y * 2 + 2
		data = Matrix(Array(repeating: false, count: width * height).chunks(of: width).map(Array.init))
	}

	subscript(position: Point) -> Bool {
		get {
			data[position]
		}
		set {
			data[position] = newValue
			modifiedPositions.insert(position)
		}
	}
}

private final class Robot {
	private struct Camera {
		let channel = BlockingChannel()

		func scan(panel: Panel, at position: Panel.Point) {
			channel.send(panel[position] ? 1 : 0)
		}
	}

	private struct Brush {
		func paint(color: Int, panel: Panel, at position: Panel.Point) {
			panel[position] = color == 1 ? true : false
		}
	}

	private let camera = Camera()
	private let brush = Brush()
	private var position: Panel.Point = .zero
	private var direction = Panel.Point(x: 0, y: -1)

	func draw(program: Program, on panel: Panel, start: Panel.Point) {
		position = start
		let output = BlockingChannel()
		var computer = Computer(program, input: camera.channel, output: output)

		// run IO
		DispatchQueue.global().async {
			while true {
				self.camera.scan(panel: panel, at: self.position)
				self.brush.paint(color: output.receive(), panel: panel, at: self.position)
				self.turn(rotation: output.receive())
			}
		}

		// run CPU
		computer.run()
	}

	private func turn(rotation: Int) {
		if rotation == 0 {
			direction = .init(x: direction.y, y: -direction.x)
		} else {
			direction = .init(x: -direction.y, y: direction.x)
		}
		position += direction
	}
}

struct Day11: Day {
	static let name = "Space Police"
	private let program: Program

	init(input: Input) {
		program = Program(code: input.lines)
	}
}

// MARK: - Part 1

extension Day11 {
	mutating func part1() -> Any {
		logPart("How many panels does it paint at least once?")

		let start = Panel.Point(x: 99, y: 99)
		let panel = Panel(centeredAround: start)
		let robot = Robot()
		robot.draw(program: program, on: panel, start: start)

		return panel.modifiedPositions.count
	}
}

// MARK: - Part 2

extension Day11 {
	mutating func part2() -> Any {
		logPart("After starting the robot on a single white panel instead, what registration identifier does it paint on your hull?")

		let start = Panel.Point(x: 44, y: 6)
		let panel = Panel(centeredAround: start)
		panel[start] = true
		let robot = Robot()
		robot.draw(program: program, on: panel, start: start)

		log(.info, "Result:")
		for line in panel.data.data {
			log(.info, line.map { $0 ? "X" : " " }.joined())
		}

		return "TODO"
	}
}
