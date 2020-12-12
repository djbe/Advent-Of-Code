//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

struct Day06: Day {
	var name: String { "Custom Customs" }

	private lazy var groups = loadInputFile(omittingEmptySubsequences: false).chunked { _, rhs in !rhs.isEmpty }
}

// MARK: - Part 1

extension Day06 {
	mutating func part1() {
		logPart("For each group, count the number of questions to which anyone answered \"yes\". What is the sum of those counts?")

		let anyAnswered = groups.reduce(0) { sum, group in
			sum + Set(group.joined()).count
		}

		log(.info, "Sum of answered by any: \(anyAnswered)")
	}
}

// MARK: - Part 2

extension Day06 {
	mutating func part2() {
		logPart("For each group, count the number of questions to which everyone answered \"yes\". What is the sum of those counts?")

		let allAnswered = groups.reduce(0) { sum, group in
			let answers = group.map(Set.init).filter { !$0.isEmpty }
			let common = answers.reduce(into: answers.first ?? []) { $0.formIntersection($1) }
			return sum + common.count
		}

		log(.info, "Sum of answered by all: \(allAnswered)")
	}
}
