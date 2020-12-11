import Algorithms
import Common
import Foundation

private struct RuleSet {
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

struct Day07: Day {
	var name: String { "Amplification Circuit" }

	private lazy var rules = RuleSet(lines: loadInputFile())
}

// MARK: - Part 1

extension RuleSet {
	func bagsThatCanContain(color: String) -> Set<String> {
		let set = rules.filter { $0.value[color] != nil }.keys
		return Set(set + set.flatMap(self.bagsThatCanContain(color:)))
	}
}

extension Day07 {
	mutating func part1() {
		logPart("What is the highest signal that can be sent to the thrusters?")

		log(.info, "Bags that can contain: \(rules.bagsThatCanContain(color: "shiny gold").count)")
	}
}

// MARK: - Part 2

extension RuleSet {
	func bagsContained(in color: String) -> Int {
		rules[color, default: [:]].reduce(into: 0) { sum, item in
			sum += item.value + item.value * bagsContained(in: item.key)
		}
	}
}

extension Day07 {
	mutating func part2() {
		logPart("What is the highest signal that can be sent to the thrusters?")

		log(.info, "Bags contained in: \(rules.bagsContained(in: "shiny gold"))")
	}
}
