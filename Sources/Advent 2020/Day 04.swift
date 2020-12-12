//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common

private struct Passport {
	private let data: [String: String]

	init?<T: StringProtocol>(_ lines: ArraySlice<T>) {
		let keyValues = lines
			.flatMap { $0.split(separator: " ") }
			.map { (String($0.split(separator: ":")[0]), String($0.split(separator: ":")[1])) }

		guard !keyValues.isEmpty else { return nil }
		data = .init(uniqueKeysWithValues: keyValues)
	}

	static func load<T: StringProtocol>(from input: [T]) -> [Passport] {
		input.chunked { _, rhs in !rhs.isEmpty }
			.compactMap(Passport.init)
	}
}

extension Passport {
	var byr: Int { Int(data["byr", default: ""]) ?? .min }
	var iyr: Int { Int(data["iyr", default: ""]) ?? .min }
	var eyr: Int { Int(data["eyr", default: ""]) ?? .min }
	var hcl: String { data["hcl", default: ""] }
	var ecl: String { data["ecl", default: ""] }
	var pid: String { data["pid", default: ""] }
	var hgt: (value: Int, unit: String) {
		let value = data["hgt", default: ""]
		guard value.matches(regex: #"^[0-9]+(cm|in)$"#) else { return (.min, "") }
		return (Int(value.dropLast(2)) ?? .min, String(value.suffix(2)))
	}
}

struct Day04: Day {
	var name: String { "Passport Processing" }

	private lazy var passports = Passport.load(from: loadInputFile(omittingEmptySubsequences: false))
}

// MARK: - Part 1

extension Passport {
	private static let mandatoryFields: Set<String> = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" /* , "cid" */ ]

	var simpleIsValid: Bool {
		Self.mandatoryFields.isSubset(of: Set(data.keys))
	}
}

extension Day04 {
	mutating func part1() {
		logPart("In your batch file, how many passports are valid?")

		log(.info, "Valid passports (simple): \(passports.filter(\.simpleIsValid).count)")
	}
}

// MARK: - Part 2

enum Validators {
	struct IntRange {
		let range: ClosedRange<Int>
		func validate(_ value: Int) -> Bool { range.contains(value) }
	}

	struct Regex {
		let regex: String
		func validate(_ value: String) -> Bool { value.matches(regex: regex) }
	}

	struct Height {
		func validate(_ value: (value: Int, unit: String)) -> Bool {
			switch value.unit {
			case "cm": return (150...193).contains(value.value)
			case "in": return (59...76).contains(value.value)
			default: return false
			}
		}
	}
}

extension Passport {
	var isValid: Bool {
		Self.mandatoryFields.isSubset(of: Set(data.keys)) &&
			Validators.IntRange(range: 1_920...2_002).validate(byr) &&
			Validators.IntRange(range: 2_010...2_020).validate(iyr) &&
			Validators.IntRange(range: 2_020...2_030).validate(eyr) &&
			Validators.Regex(regex: #"^#[0-9a-f]{6}$"#).validate(hcl) &&
			Validators.Regex(regex: #"^amb|blu|brn|gry|grn|hzl|oth$"#).validate(ecl) &&
			Validators.Regex(regex: #"^[0-9]{9}$"#).validate(pid) &&
			Validators.Height().validate(hgt)
	}
}

extension Day04 {
	mutating func part2() {
		logPart("In your batch file, how many passports are valid?")

		log(.info, "Valid passports (complex): \(passports.filter(\.isValid).count)")
	}
}
