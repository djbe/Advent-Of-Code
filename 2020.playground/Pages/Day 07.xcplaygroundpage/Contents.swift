//: [Previous Day](@previous)
//: # Day 7: Handy Haversacks

import Foundation

struct RuleSet {
	let rules: [String: [String: Int]]

	init<T: StringProtocol>(lines: [T]) {
		rules = Dictionary(uniqueKeysWithValues: lines.compactMap(Self.parse(line:)))
	}

	private static func parse<T: StringProtocol>(line: T) -> (String, [String: Int])? {
		guard !line.contains("no other bags.") else { return nil }

		let components = line.components(separatedBy: " contain ")
		let color = String(components[0].dropLast(5))
		let contained: [(String, Int)] = components[1].dropLast().components(separatedBy: ", ").map {
			let amount = Int($0.split(separator: " ")[0]) ?? 0
			let color = $0.split(separator: " ").dropFirst().dropLast().joined(separator: " ")
			return (color, amount)
		}

		return (color, Dictionary(uniqueKeysWithValues: contained))
	}
}

let rules = RuleSet(lines: loadInputFile("input"))

//: ### How many bag colors can eventually contain at least one shiny gold bag?

extension RuleSet {
	func bagsThatCanContain(color: String) -> Set<String> {
		let set = rules.filter { $0.value[color] != nil }.keys
		return Set(set + set.flatMap(self.bagsThatCanContain(color:)))
	}
}

print("Bags that can contain: \(rules.bagsThatCanContain(color: "shiny gold").count)")

//: ### How many individual bags are required inside your single shiny gold bag?

extension RuleSet {
	func bagsContained(in color: String) -> Int {
		rules[color, default: [:]].reduce(into: 0) { sum, item in
			sum += item.value + item.value * bagsContained(in: item.key)
		}
	}
}

print("Bags contained in: \(rules.bagsContained(in: "shiny gold"))")

//: [Next Day](@next)
