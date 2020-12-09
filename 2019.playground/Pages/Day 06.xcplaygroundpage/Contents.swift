//: [Previous Day](@previous)
//: # Day 6: Universal Orbit Map

struct Map {
	private let map: [String: [String]]

	init<T: StringProtocol>(_ data: [T]) {
		let orbits = input.map { $0.components(separatedBy: ")") }.map { ($0[0], [$0[1]]) }
		map = Dictionary(orbits) { $0 + $1 }
	}

	subscript(key: String) -> [String] {
		map[key, default: []]
	}
}

let input = loadInputFile("input")
let map = Map(input)

//: ### What is the total number of direct and indirect orbits in your map data?

extension Map {
	func checksum(from start: String = "COM", depth: Int = 1) -> Int {
		return self[start].count * depth +
			self[start].map { checksum(from: $0, depth: depth + 1) }.reduce(0, +)
	}
}

print("Checksum: \(map.checksum())")

//: ### What is the minimum number of orbital transfers required to move from the object YOU are orbiting to the object SAN is orbiting?

extension Map {
	func path(from start: String = "COM", to end: String) -> [String] {
		if let endParent = map.first(where: { $0.value.contains(end) })?.key {
			return path(from: start, to: endParent) + [endParent]
		} else {
			return []
		}
	}

	func transfers(from start: String, to end: String) -> Int {
		let lhs = path(to: start)
		let rhs = path(to: end)

		let firstDifferent = (Array(zip(lhs, rhs)).firstIndex { $0 != $1 } ?? 0)
		return (lhs.count - firstDifferent) + (rhs.count - firstDifferent)
	}
}

print("Transfers: \(map.transfers(from: "YOU", to: "SAN"))")

//: [Next Day](@next)
