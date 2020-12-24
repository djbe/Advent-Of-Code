//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private struct Menu {
	var allergens: [String: Set<String>] = [:]
	let food: [Set<String>]

	init<T: StringProtocol>(_ lines: [Line<T>]) {
		let parsedLines: [(ingredients: Set<String>, allergens: Set<String>)] = lines.map {
			let comps = $0.raw.dropLast().components(separatedBy: " (")
			return (
				Set(comps[0].split(separator: " ").map(String.init)),
				Set(comps[1].dropFirst(9).components(separatedBy: ", "))
			)
		}

		allergens = Self.allergens(from: parsedLines)
		food = parsedLines.map(\.ingredients)
	}

	static func allergens(from lines: [(ingredients: Set<String>, allergens: Set<String>)]) -> [String: Set<String>] {
		var result: [String: Set<String>] = [:]

		for line in lines {
			for allergen in line.allergens {
				let reduced = result[allergen, default: line.ingredients].intersection(line.ingredients)
				if reduced.count == 1 {
					for allergen in result.keys {
						result[allergen]?.remove(reduced.first ?? "")
					}
				}
				result[allergen] = reduced
			}
		}

		return result
	}
}

struct Day21: Day {
	static let name = "Allergen Assessment"
	private var menu: Menu

	init(input: Input) {
		menu = Menu(input.lines)
	}
}

// MARK: - Part 1

extension Menu {
	// all ingredients that aren't connected to an allergen
	var safeIngredients: Set<String> {
		food.reduce(into: Set<String>()) { $0.formUnion($1) }
			.subtracting(allergens.values.flatMap { $0 })
	}
}

extension Day21 {
	mutating func part1() -> Any {
		logPart("Determine which ingredients cannot possibly contain any of the allergens in your list. How many times do any of those ingredients appear?")

		let ingredients = menu.safeIngredients
		return menu.food
			.map { $0.intersection(ingredients).count }
			.sum
	}
}

// MARK: - Part 2

extension Menu {
	// try to reduce allergen list to 1 ingredient per allergen
	mutating func reduceAllergens() {
		while allergens.contains(where: { $0.value.count > 1 }) {
			for (allergen, ingredients) in allergens where ingredients.count == 1 {
				// remove known allergen from other lists
				allergens.keys.filter { $0 != allergen }
					.forEach { allergens[$0]?.remove(ingredients.first ?? "") }
			}
		}
	}
}

extension Day21 {
	mutating func part2() -> Any {
		logPart("Time to stock your raft with supplies. What is your canonical dangerous ingredient list?")

		menu.reduceAllergens()

		return menu.allergens
			.sorted { $0.key < $1.key }
			.map { $0.value.first ?? "" }
			.joined(separator: ",")
	}
}
