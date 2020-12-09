//: [Previous Day](@previous)
//: # Day 2

let input = loadInputFile("input")
var program = Program(code: input)

//: ### What value is left at position 0 after the program halts?

extension Program {
	mutating func fix1202ProgramAlarm() {
		set(noun: 12, verb: 2)
	}
}

program.fix1202ProgramAlarm()
let computer = Computer(program)
computer.run()
print("Result after execution: \(computer.firstMemoryByte)")

//: ### What is 100 * noun + verb?

extension Program {
	mutating func set(noun: Int, verb: Int) {
		data[1] = noun
		data[2] = verb
	}
}

for choice in (0...99).map({ $0 }).combinations(ofCount: 2) {
	program.set(noun: choice[0], verb: choice[1])
	let computer = Computer(program)
	computer.run()
	if computer.firstMemoryByte == 19690720 {
		let result = 100 * choice[0] + choice[1]
		print("Found combination: \(result)")
	}
}

//: [Next Day](@next)
