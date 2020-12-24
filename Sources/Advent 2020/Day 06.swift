//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day06: Day {
	static let name = "Custom Customs"
	private let groups: [[Line<Substring>]]

	init(input: Input) {
		groups = input.sections
	}
}

// MARK: - Part 1

extension Day06 {
	mutating func part1() -> Any {
		logPart("For each group, count the number of questions to which anyone answered \"yes\". What is the sum of those counts?")

		return groups.reduce(0) { sum, group in
			sum + Set(group.map(\.raw).joined()).count
		}
	}
}

// MARK: - Part 2

extension Day06 {
	mutating func part2() -> Any {
		logPart("For each group, count the number of questions to which everyone answered \"yes\". What is the sum of those counts?")

		return groups.reduce(0) { sum, group in
			let answers = group.map(\.raw).map(Set.init).filter { !$0.isEmpty }
			let common = answers.reduce(into: answers.first ?? []) { $0.formIntersection($1) }
			return sum + common.count
		}
	}
}
