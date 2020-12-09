//: [Previous Day](@previous)
//: # Day 12:  The N-Body Problem

final class Object {
	var position: Vector3<Int>
	var velocity: Vector3<Int> = Vector3([0, 0, 0])

	init<T: StringProtocol>(_ input: T) {
		position = Vector3(input.dropFirst().dropLast().split(separator: ",").compactMap { Int(String($0.split(separator: "=")[1])) })
	}

	func applyGravity(with object: Object) {
		let change = Vector3<Int>(
			x: position.x == object.position.x ? 0 : position.x < object.position.x ? 1 : -1,
			y: position.y == object.position.y ? 0 : position.y < object.position.y ? 1 : -1,
			z: position.z == object.position.z ? 0 : position.z < object.position.z ? 1 : -1
		)
		velocity += change
		object.velocity -= change
	}
}

final class System: CustomStringConvertible {
	var objects: [Object]

	init<T: StringProtocol>(lines: [T]) {
		objects = lines.map(Object.init)
	}

	var description: String {
		objects.map { "pos=\($0.position), vel=\($0.velocity)" }.joined(separator: "\n")
	}

	func step() {
		objects.combinations(ofCount: 2).forEach {
			$0[0].applyGravity(with: $0[1])
		}
		objects.forEach { $0.position += $0.velocity }
	}
}

let input = loadInputFile("input")

//: ### What is the total energy in the system after simulating the moons given in your scan for 1000 steps?

extension System {
	var energy: Int {
		objects.map { $0.position.coordinates.map(abs).reduce(0, +) * $0.velocity.coordinates.map(abs).reduce(0, +) }
			.reduce(0, +)
	}
}

do {
	let system = System(lines: input)
	for i in 1...1000 {
		system.step()
	}

	print("Total energy: \(system.energy)")
}

//: ### How many steps does it take to reach the first state that exactly matches a previous state?

extension System {
	func findStepsForCycle(axis: KeyPath<Vector3<Int>, Int>) -> Int {
		var steps = 0

		repeat {
			step()
			steps += 1
		} while !objects.map { $0.velocity[keyPath: axis] }.allSatisfy { $0 == 0 }

		return steps * 2
	}
}

do {
	let cycles: [Int] = [\Vector3<Int>.x, \.y, \.z].map {
		let system = System(lines: input)
		return system.findStepsForCycle(axis: $0)
	}

	print("Found cycles for each axis: \(cycles)")
	print("Result: \(lcm(cycles))")
}

//: [Next Day](@next)
