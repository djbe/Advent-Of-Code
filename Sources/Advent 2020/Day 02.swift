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
	static func parse<T: StringProtocol>(_ line: T) -> (policy: PasswordPolicy, remainder: String) {
		let parts = line.split(separator: " ")

		if let policy = PasswordPolicy(policy: parts[0], character: parts[1]) {
			return (policy, parts.dropFirst(2).joined(separator: " "))
		} else {
			preconditionFailure("Unknown policy: \(line)")
		}
	}
}

struct Day02: Day {
	var name: String { "Password Philosophy" }

	private lazy var parsed = loadInputFile().map(PasswordPolicy.parse(_:))
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
	mutating func part1() {
		logPart("How many passwords are valid according to their policies?")

		let result = parsed
			.map { $0.policy.validateOld($0.remainder) ? 1 : 0 }
			.reduce(0, +)

		log(.info, "Valid passwords (old): \(result)")
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
	mutating func part2() {
		logPart("How many passwords are valid according to the new interpretation of the policies?")

		let result = parsed
			.map { $0.policy.validateNew($0.remainder) ? 1 : 0 }
			.reduce(0, +)

		log(.info, "Valid passwords (new): \(result)")
	}
}
