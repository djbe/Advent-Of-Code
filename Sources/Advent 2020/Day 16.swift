//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private struct Rule: Hashable {
	let name: String
	let ranges: [ClosedRange<Int>]

	init<T: StringProtocol>(_ line: Line<T>) {
		name = line.raw.components(separatedBy: ": ")[0]
		ranges = line.raw.components(separatedBy: ": ")[1].components(separatedBy: " or ").map {
			let lower = Int($0.split(separator: "-")[0]) ?? 0
			let upper = Int($0.split(separator: "-")[1]) ?? 0
			return lower...upper
		}
	}

	func matches(_ value: Int) -> Bool {
		ranges.contains { $0.contains(value) }
	}
}

private struct Ticket {
	let numbers: [Int]
}

private struct File {
	let rules: [Rule]
	let myTicket: Ticket
	let tickets: [Ticket]

	init(_ input: Input) {
		rules = input.sections[0].map(Rule.init)
		myTicket = Ticket(numbers: input.sections[1].last?.csvIntegers ?? [])
		tickets = input.sections[2].dropFirst().map(\.csvIntegers).map(Ticket.init(numbers:))
	}
}

struct Day16: Day {
	static let name = "Ticket Translation"
	private let file: File

	init(input: Input) {
		file = File(input)
	}
}

// MARK: - Part 1

extension Ticket {
	func invalidValues(for rules: [Rule]) -> [Int] {
		numbers.filter { number in !rules.contains { $0.matches(number) } }
	}
}

extension Day16 {
	mutating func part1() -> Any {
		logPart("Consider the validity of the nearby tickets you scanned. What is your ticket scanning error rate?")

		let invalidValues = file.tickets.map { $0.invalidValues(for: file.rules) }.flatMap { $0 }

		return invalidValues.sum
	}
}

// MARK: - Part 2

extension Day16 {
	mutating func part2() -> Any {
		logPart("Once you work out which field is which, look for the six fields on your ticket that start with the word departure. What do you get if you multiply those six values together?")

		let validTickets = file.tickets.filter { $0.invalidValues(for: file.rules).isEmpty }

		// start with all rules unknown, and keep going until we've found matches for all
		let fields = 0..<validTickets[0].numbers.count
		var mappedFields: [Int: Rule] = [:]
		var unknownRules = Set(file.rules)
		while !unknownRules.isEmpty {
			for field in fields where mappedFields[field] == nil {
				let values = validTickets.map { $0.numbers[field] }
				let possibleRules = unknownRules.filter { rule in values.allSatisfy { rule.matches($0) } }

				// only consider a rule as found for a field, if no other rule matches it
				if possibleRules.count == 1, let rule = possibleRules.first {
					mappedFields[field] = rule
					unknownRules.remove(rule)
				}
			}
		}

		let departureFields = mappedFields.filter { $0.value.name.hasPrefix("departure") }.keys
		let departureValues = departureFields.map { file.myTicket.numbers[$0] }

		return departureValues.product
	}
}
