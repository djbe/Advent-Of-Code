//: [Previous Day](@previous)
//: # Day 11: Space Police

import Foundation

final class Panel {
	typealias Point = Vector<Int>

	var data: Grid<Bool>
	var modifiedPositions: Set<Point> = []

	init(centeredAround point: Point) {
		let width = point.x * 2 + 2
		let height = point.y * 2 + 2
		data = Grid(Array(repeating: false, count: width * height).chunks(of: width).map(Array.init))
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

struct Camera {
	let channel = Channel<Int>()

	func scan(panel: Panel, at position: Panel.Point) {
		channel.send(panel[position] ? 1 : 0)
	}
}

struct Brush {
	func paint(color: Int, panel: Panel, at position: Panel.Point) {
		panel[position] = color == 1 ? true : false
	}
}

final class Robot {
	private let camera = Camera()
	private let brush = Brush()
	private var position: Panel.Point = .zero
	private var direction = Panel.Point(x: 0, y: -1)

	func draw(on panel: Panel, start: Panel.Point) {
		position = start
		let output = Channel<Int>()
		let computer = Computer(program, input: camera.channel, output: output)

		// run IO
		DispatchQueue.global().async {
			while true {
				self.camera.scan(panel: panel, at: self.position)
				if let color = output.receive() {
					self.brush.paint(color: color, panel: panel, at: self.position)
				}
				if let rotation = output.receive() {
					self.turn(rotation: rotation)
				}
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

let input = loadInputFile("input")
let program = Program(code: input)

//: ### How many panels does it paint at least once?

do {
	let start = Panel.Point(x: 99, y: 99)
	let panel = Panel(centeredAround: start)

	let robot = Robot()
	robot.draw(on: panel, start: start)

	let result = panel.modifiedPositions.count
	print("Number of panels painted: \(result)")
}

//: ### After starting the robot on a single white panel instead, what registration identifier does it paint on your hull?

do {
	let start = Panel.Point(x: 44, y: 6)
	let panel = Panel(centeredAround: start)
	panel[start] = true

	let robot = Robot()
	robot.draw(on: panel, start: start)

	print("Result:")
	for line in panel.data.data {
		print(line.map { $0 ? "X" : " " }.joined())
	}
}

//: [Next Day](@next)
