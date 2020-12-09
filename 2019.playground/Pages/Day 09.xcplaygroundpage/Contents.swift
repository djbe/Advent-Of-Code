//: [Previous Day](@previous)
//: # Day 9

let input = loadInputFile("input")
let program = Program(code: input)

//: ### What BOOST keycode does it produce?

do {
	let output = Channel<Int>()
	let computer = Computer(program, input: Channel(1), output: output)
	computer.run()
	print("Keycode: \(output.contents)")
}

//: ### What are the coordinates of the distress signal?

do {
	let output = Channel<Int>()
	let computer = Computer(program, input: Channel(2), output: output)
	computer.run()
	print("Coordinates: \(output.contents)")
}

//: [Next Day](@next)
