//: [Previous Day](@previous)
//: # Day 6: Custom Customs

let input = loadInputFile("input", omittingEmptySubsequences: false)
let groups = input.chunked(by: { lhs, rhs in rhs != "" })

//: ### For each group, count the number of questions to which anyone answered "yes". What is the sum of those counts?

let anyAnswered = groups.reduce(0) { sum, group in
	sum + Set(group.joined()).count
}

print("Sum of answered by any: \(anyAnswered)")

//: ### For each group, count the number of questions to which everyone answered "yes". What is the sum of those counts?

let allAnswered = groups.reduce(0) { sum, group in
	let answers = group.map(Set.init).filter { !$0.isEmpty }
	let common = answers.reduce(into: answers.first ?? []) { $0.formIntersection($1) }
	return sum + common.count
}

print("Sum of answered by all: \(allAnswered)")

//: [Next Day](@next)
