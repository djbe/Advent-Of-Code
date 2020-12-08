//: [Previous Day](@previous)
//: # Day 2: Password Philosophy

public struct PasswordPolicy {
	let indices: [Int]
	let needle: Character

	init?<T: StringProtocol>(policy: T, character: T) {
		guard let character = character.first else { preconditionFailure("Missing character!") }
		indices = policy.components(separatedBy: "-").compactMap(Int.init)
		needle = character
	}
}

public extension PasswordPolicy {
	static func parse<T: StringProtocol>(_ line: T) -> (policy: PasswordPolicy, remainder: String) {
		let parts = line.split(separator: " ")

		if let policy = PasswordPolicy(policy: parts[0], character: parts[1]) {
			return (policy, parts.dropFirst(2).joined(separator: " "))
		} else {
			preconditionFailure("Unknown policy: \(line)")
		}
	}
}

let input = loadInputFile("input")
let parsed = input.map(PasswordPolicy.parse(_:))

//: ### How many passwords are valid according to their policies?

public extension PasswordPolicy {
	/// Check if needle appears N times, with N in our range
	func validateOld<T: StringProtocol>(_ password: T) -> Bool {
		let result = password.filter { $0 == needle }.count
		return (indices[0]...indices[1]).contains(result)
	}
}

do {
	let result = parsed
		.map { $0.policy.validateOld($0.remainder) ? 1 : 0 }
		.reduce(0, +)

	print("Valid passwords (old): \(result)")
}

//: ### How many passwords are valid according to the new interpretation of the policies?

extension PasswordPolicy {
	/// Check if needle appears at either index (but not both)
	func validateNew<T: StringProtocol>(_ password: T) -> Bool {
		indices
			.map { password[$0 - 1] }
			.filter { $0 == needle }
			.count == 1
	}
}

do {
	let result = parsed
		.map { $0.policy.validateNew($0.remainder) ? 1 : 0 }
		.reduce(0, +)

	print("Valid passwords (new): \(result)")
}

//: [Next Day](@next)
