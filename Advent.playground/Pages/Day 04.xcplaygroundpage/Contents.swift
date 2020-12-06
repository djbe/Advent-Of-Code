//: [Previous Day](@previous)
//: # Day 4: Passport Processing

struct Passport {
	private let data: [String: String]

	init?<T: StringProtocol>(_ lines: ArraySlice<T>) {
		let keyValues = lines
			.flatMap { $0.split(separator: " ") }
			.map { (String($0.split(separator: ":")[0]), String($0.split(separator: ":")[1])) }

		guard !keyValues.isEmpty else { return nil }
		data = .init(uniqueKeysWithValues: keyValues)
	}

	static func load<T: StringProtocol>(from input: [T]) -> [Passport] {
		input.chunked(by: { lhs, rhs in rhs != "" })
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

let input = loadInputFile("input", omittingEmptySubsequences: false)
let passports = Passport.load(from: input)

//: ### In your batch file, how many passports are valid?

extension Passport {
	private static let mandatoryFields: Set<String> = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"/*, "cid"*/]

	var simpleIsValid: Bool {
		Self.mandatoryFields.isSubset(of: Set(data.keys))
	}
}

print("Valid passports (simple): \(passports.filter(\.simpleIsValid).count)")

//: ### In your batch file, how many passports are valid?

protocol Validator {
	associatedtype Value
	func validate(_ value: Value) -> Bool
}

enum Validators {
	struct IntRange: Validator {
		let range: ClosedRange<Int>
		func validate(_ value: Int) -> Bool {
			range.contains(value)
		}
	}

	struct Regex: Validator {
		let regex: String
		func validate(_ value: String) -> Bool {
			value.matches(regex: regex)
		}
	}

	struct Height: Validator {
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
			Validators.IntRange(range: 1920...2002).validate(byr) &&
			Validators.IntRange(range: 2010...2020).validate(iyr) &&
			Validators.IntRange(range: 2020...2030).validate(eyr) &&
			Validators.Regex(regex: #"^#[0-9a-f]{6}$"#).validate(hcl) &&
			Validators.Regex(regex: #"^amb|blu|brn|gry|grn|hzl|oth$"#).validate(ecl) &&
			Validators.Regex(regex: #"^[0-9]{9}$"#).validate(pid) &&
			Validators.Height().validate(hgt)
	}
}

print("Valid passports: \(passports.filter(\.isValid).count)")

//: [Next Day](@next)
