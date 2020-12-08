//: [Previous Day](@previous)
//: # Day 1: Report Repair

func findMatchingTo2020(numbers: [Int], count: Int) -> [Int]? {
	numbers.combinations(ofCount: count).first {
		$0.reduce(0, +) == 2020
	}
}

let input: [Int] = loadInputFile("input").compactMap { Int(String($0)) }

//: ### Find the two entries that sum to 2020; what do you get if you multiply them together?

if let matching = findMatchingTo2020(numbers: input, count: 2) {
	print("Matching 2 numbers give \(matching.reduce(1, *))")
}

//: ### What is the product of the three entries that sum to 2020?

if let matching = findMatchingTo2020(numbers: input, count: 3) {
	print("Matching 3 numbers give \(matching.reduce(1, *))")
}

//: [Next Day](@next)
