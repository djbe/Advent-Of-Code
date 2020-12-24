//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

struct Reaction {
	let amount: Int
	let produced: String
	let ingredients: [String: Int]

	init<T: StringProtocol>(_ line: Line<T>) {
		let comps = line.raw.components(separatedBy: " => ")
		amount = Self.parseItem(comps[1]).amount
		produced = Self.parseItem(comps[1]).name
		ingredients = Dictionary(uniqueKeysWithValues: comps[0].components(separatedBy: ", ").map(Self.parseItem))
	}

	private static func parseItem<T: StringProtocol>(_ item: T) -> (name: String, amount: Int) {
		(String(item.split(separator: " ")[1]), Int(item.split(separator: " ")[0]) ?? 0)
	}

	func multiplier(for amount: Int) -> Int {
		Int(ceil(Float(amount) / Float(self.amount)))
	}
}

struct ReactionList {
	let reactions: [String: Reaction]

	init<T: StringProtocol>(lines: [Line<T>]) {
		reactions = Dictionary(uniqueKeysWithValues: lines.map(Reaction.init).map { ($0.produced, $0) })
	}
}

struct Day14: Day {
	static let name = "Space Stoichiometry"
	private let list: ReactionList

	init(input: Input) {
		list = ReactionList(lines: input.lines)
	}
}

// MARK: - Part 1

extension ReactionList {
	func oreNeeded(for target: String, amount targetAmount: Int) -> Int {
		var inventory: [String: Int] = [:]
		var ore = 0
		var queue = [(name: target, amount: targetAmount)]

		while !queue.isEmpty {
			let item = queue.removeFirst()

			if item.name == "ORE" {
				ore += item.amount
			} else if inventory[item.name, default: 0] >= item.amount {
				inventory[item.name, default: 0] -= item.amount
			} else if let reaction = reactions[item.name] {
				let needed = item.amount - inventory[item.name, default: 0]
				let multiplier = reaction.multiplier(for: needed)

				queue.append(contentsOf: reaction.ingredients.map { ($0.key, $0.value * multiplier) })
				inventory[item.name, default: 0] = reaction.amount * multiplier - needed
			}
		}

		return ore
	}
}

extension Day14 {
	mutating func part1() -> Any {
		logPart("Given the list of reactions in your puzzle input, what is the minimum amount of ORE required to produce exactly 1 FUEL?")

		return list.oreNeeded(for: "FUEL", amount: 1)
	}
}

// MARK: - Part 2

extension Day14 {
	mutating func part2() -> Any {
		logPart("Given 1 trillion ORE, what is the maximum amount of FUEL you can produce?")

		let trillion = 1_000_000_000_000
		let bound = trillion / list.oreNeeded(for: "FUEL", amount: 1)
		let range = (bound...(bound * 2)).reversed()

		return range[range.partitioningIndex { list.oreNeeded(for: "FUEL", amount: $0) <= trillion }]
	}
}
