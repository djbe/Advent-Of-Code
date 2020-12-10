//: [Previous Day](@previous)
//: # Day 5: Sunny with a Chance of Asteroids

let input = loadInputFile("input")
let program = Program(code: input)

//: ### After providing 1 to the only input instruction and passing all the tests, what diagnostic code does the program produce?

do {
	let computer = Computer(program, input: Channel(1))
	let result = computer.runAndWaitForOutput()
	print("Diagnostic code: \(result)")
}

//: ### What is the diagnostic code for system ID 5?

do {
	let computer = Computer(program, input: Channel(5))
	let result = computer.runAndWaitForOutput()
	print("Diagnostic code: \(result)")
}

//: [Next Day](@next)
