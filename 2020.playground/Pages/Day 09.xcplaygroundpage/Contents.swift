//: [Previous Day](@previous)
//: # Day 9: Encoding Error

let input = loadInputFile("input")
let numbers: [Int] = input.compactMap { Int(String($0)) }

//: ### What is the first number that does not have this property?

func check(sequence: [Int], history: Int) -> Int? {
	sequence.slidingWindows(ofCount: history + 1).first { numbers in
		let newNumber = numbers.last ?? 0
		return !Array(numbers.prefix(history)).permutations(ofCount: 2)
			.contains { $0.reduce(0, +) == newNumber }
	}?.last
}

let invalidNumber = check(sequence: numbers, history: 25) ?? 0
print("Non-matching number: \(invalidNumber)")

//: ### What is the encryption weakness in your XMAS-encrypted list of numbers?

func findWeakness(sequence: [Int], invalid: Int) -> [Int] {
	for size in 3... {
		if let result = sequence.slidingWindows(ofCount: size).first(where: { $0.reduce(0, +) == invalid }) {
			return Array(result)
		}
	}
	return []
}

let result = findWeakness(sequence: numbers, invalid: invalidNumber)
let weakness = (result.min() ?? 0) + (result.max() ?? 0)
print("Found weakness: \(result) --> \(weakness)")

//: [Next Day](@next)
