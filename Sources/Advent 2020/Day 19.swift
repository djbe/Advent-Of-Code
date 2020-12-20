//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation
import Regex

private struct RuleSet {
	enum Rule {
		case literal(Character)
		case list([Int])
		case choice([[Int]])

		init(_ value: String) {
			if value.hasPrefix("\"") {
				self = .literal(value[1])
			} else if value.contains("|") {
				let sequences = value.components(separatedBy: " | ")
				self = .choice(sequences.map {
					$0.split(separator: " ").compactMap { Int($0) }
				})
			} else {
				self = .list(value.split(separator: " ").compactMap { Int($0) })
			}
		}
	}

	var rules: [Int: Rule]

	init<T: StringProtocol>(lines: [T]) {
		rules = Dictionary(uniqueKeysWithValues: lines.map { line in
			let comps = line.components(separatedBy: ": ")
			let identifier = Int(comps[0]) ?? 0
			return (identifier, Rule(comps[1]))
		})
	}

	func regex(with patternBuilder: (Int) -> String) -> Regex {
		(try? Regex(string: "^\(patternBuilder(0))$")) ?? Regex("")
	}
}

struct Day19: Day {
	var name: String { "Monster Messages" }

	private lazy var input = loadInputFile(omittingEmptySubsequences: false).chunked { !$1.isEmpty }
	private lazy var ruleset = RuleSet(lines: Array(input[0]))
	private lazy var messages = input[1]
}

// MARK: - Part 1

extension RuleSet {
	func simpleRegexPattern(for rule: Int) -> String {
		switch rules[rule] {
		case .literal(let character):
			return String(character)
		case .list(let identifiers):
			return String("(\(identifiers.map(simpleRegexPattern(for:)).joined()))")
		case .choice(let choices):
			return "(\(choices.map { $0.map(simpleRegexPattern(for:)).joined() }.joined(separator: "|")))"
		case .none:
			return ""
		}
	}
}

extension Day19 {
	mutating func part1() -> Any {
		logPart("How many messages completely match rule 0?")

		let regex = ruleset.regex(with: ruleset.simpleRegexPattern(for:))

		return messages.filter { regex.matches(String($0)) }.count
	}
}

// MARK: - Part 2

extension RuleSet {
	// maximum length of a message
	static var maxLength = 0

	func complexRegexPattern(for rule: Int) -> String {
		// simple repeat
		if rule == 8 {
			return complexRegexPattern(for: 42) + "+"
		}

		// repeat sequence a few times, we cannot repeat more than N times, where N is 2^N == maxlength
		if rule == 11 {
			let lhs = complexRegexPattern(for: 42)
			let rhs = complexRegexPattern(for: 31)
			let repeats = Int(log2(Double(Self.maxLength)))
			let options = (1...repeats)
				.map { (Array(repeating: lhs, count: $0) + Array(repeating: rhs, count: $0)).joined() }
				.joined(separator: "|")
			return "(?:\(options))"
		}

		switch rules[rule] {
		case .literal(let character):
			return String(character)
		case .list(let identifiers):
			return identifiers.map(complexRegexPattern(for:)).joined()
		case .choice(let choices):
			return "(\(choices.map { $0.map(complexRegexPattern(for:)).joined() }.joined(separator: "|")))"
		case .none:
			return ""
		}
	}
}

extension Day19 {
	mutating func part2() -> Any {
		logPart("After updating rules 8 and 11, how many messages completely match rule 0?")

		RuleSet.maxLength = messages.map(\.count).max() ?? 0
		let regex = ruleset.regex(with: ruleset.complexRegexPattern(for:))

		return messages.filter { regex.matches(String($0)) }.count
	}
}
