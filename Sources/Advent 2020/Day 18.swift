//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation
import Regex

private struct Solver {
	let regexes: [Regex]

	init(order: String...) {
		regexes = (order.map { "\\(\($0)\\)" } + order).compactMap { try? Regex(string: $0) }
	}

	func resolve(line: String) -> Int {
		var current = line

		while true {
			guard let match = regexes.lazy.compactMap({ $0.firstMatch(in: current) }).first else { break }
			let resolved = resolve(expression: match.matchedString)
			current.replaceSubrange(match.range, with: "\(resolved)")
		}

		return Int(current) ?? 0
	}

	// unfortunately MatchResult.captures doesn't correctly handle repeating groups, so just split ourselves
	private func resolve(expression: String) -> Int {
		let cleaned = expression[0] == "(" ? expression.dropFirst().dropLast() : expression[...]
		let items = cleaned.split(separator: " ")

		var result = Int(items[0]) ?? 0
		for (operand, rhs) in zip(items.dropFirst().striding(by: 2), items.dropFirst(2).striding(by: 2)) {
			if operand == "+" {
				result += Int(rhs) ?? 0
			} else if operand == "*" {
				result *= Int(rhs) ?? 0
			}
		}

		return result
	}
}

struct Day18: Day {
	static let name = "Operation Order"
	private let lines: [String]

	init(input: Input) {
		lines = input.rawLines.map(String.init)
	}
}

// MARK: - Part 1

extension Day18 {
	mutating func part1() -> Any {
		logPart("Before you can help with the homework, you need to understand it yourself. Evaluate the expression on each line of the homework; what is the sum of the resulting values?")

		let solver = Solver(order: #"(\d+)(?: (\+|\*) (\d+))+"#)
		let results = lines.map(solver.resolve(line:))

		return results.sum
	}
}

// MARK: - Part 2

extension Day18 {
	mutating func part2() -> Any {
		logPart("What do you get if you add up the results of evaluating the homework problems using these new rules?")

		let solver = Solver(order: #"(\d+)(?: (\+) (\d+))+"#, #"(\d+)(?: (\*) (\d+))+"#)
		let results = lines.map(solver.resolve(line:))

		return results.sum
	}
}
