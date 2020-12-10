//: [Previous Day](@previous)
//: # Day 4: Secure Container

let range = 382345...843167

//: ### How many different passwords within the range given in your puzzle input meet these criteria?

func isValid(password: Int) -> Bool {
	let string = "\(password)"
	guard range.contains(password) else { return false }
	guard zip(string, string.dropFirst()).allSatisfy({ $0 <= $1 }) else { return false }
	return zip(string, string.dropFirst()).contains { $0 == $1 }
}

//do {
//	let result = range.filter(isValid(password:)).count
//	print("Number of valid passwords: \(result)")
//}

//: ### How many different passwords within the range given in your puzzle input meet all of the criteria?

func betterIsValid(password: Int) -> Bool {
	guard isValid(password: password) else { return false }

	let string = "\(password)"
	return zip(0..., string.dropLast()).contains { (idx: Int, char: Character) -> Bool in
		char == string[idx + 1] && string[safe: idx - 1] != char && string[safe: idx + 2] != char
	}
}

do {
	let result = range.filter(betterIsValid(password:))
	print("Number of valid passwords: \(result.count)")
}

//: [Next Day](@next)
