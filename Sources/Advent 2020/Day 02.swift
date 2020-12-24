//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private struct PasswordPolicy {
	let indices: [Int]
	let needle: Character

	init?<T: StringProtocol>(policy: T, character: T) {
		guard let character = character.first else { preconditionFailure("Missing character!") }
		indices = policy.components(separatedBy: "-").compactMap(Int.init)
		needle = character
	}
}

extension PasswordPolicy {
	static func parse<T: StringProtocol>(_ line: Line<T>) -> (policy: PasswordPolicy, remainder: String) {
		if let policy = PasswordPolicy(policy: line.rawWords[0], character: line.rawWords[1]) {
			return (policy, line.rawWords.dropFirst(2).joined(separator: " "))
		} else {
			preconditionFailure("Unknown policy: \(line)")
		}
	}
}

struct Day02: Day {
	static let name = "Password Philosophy"
	private let policies: [(policy: PasswordPolicy, remainder: String)]

	init(input: Input) {
		policies = input.lines.map(PasswordPolicy.parse(_:))
	}
}

// MARK: - Part 1

extension PasswordPolicy {
	/// Check if needle appears N times, with N in our range
	func validateOld<T: StringProtocol>(_ password: T) -> Bool {
		let result = password.filter { $0 == needle }.count
		return (indices[0]...indices[1]).contains(result)
	}
}

extension Day02 {
	mutating func part1() -> Any {
		logPart("How many passwords are valid according to their policies?")

		return policies
			.map { $0.policy.validateOld($0.remainder) ? 1 : 0 }
			.sum
	}
}

// MARK: - Part 2

extension PasswordPolicy {
	/// Check if needle appears at either index (but not both)
	func validateNew<T: StringProtocol>(_ password: T) -> Bool {
		indices
			.map { password[$0 - 1] }
			.filter { $0 == needle }
			.count == 1
	}
}

extension Day02 {
	mutating func part2() -> Any {
		logPart("How many passwords are valid according to the new interpretation of the policies?")

		return policies
			.map { $0.policy.validateNew($0.remainder) ? 1 : 0 }
			.sum
	}
}
