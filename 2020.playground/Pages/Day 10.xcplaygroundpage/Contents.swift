//: [Previous Day](@previous)
//: # Day 10: Adapter Array

let input = loadInputFile("input")
let adapters: [Int] = input.compactMap { Int(String($0)) }.sorted(by: >)
let device = (adapters.first ?? 0) + 3

//: ### What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?

let sequence = [device] + adapters + [0]
let diffs = Dictionary(grouping: zip(sequence, sequence.dropFirst()).map(-)) { $0 }.mapValues(\.count)
print("Differences in jolts: \(diffs[1, default: 0] * diffs[3, default: 0])")

//: ### What is the total number of distinct ways you can arrange the adapters to connect the charging outlet to your device?

func countPaths(in chunk: ArraySlice<Int>) -> Int {
	guard chunk.count > 2 else { return 1 }

	// where can we jump to from here?
	let start = chunk.first ?? 0
	let options = zip(1..., chunk.dropFirst().prefix(3)).filter { $1 <= start + 3 }

	return options.map { countPaths(in: chunk.dropFirst($0.0)) }.reduce(0, +)
}

// find chunks in the sequence that are 3 apart --> where the combinations are
let chunks = sequence.reversed().map { $0 }.chunked { $1 < $0 + 3 }
let pathCount = chunks.map(countPaths(in:)).reduce(1, *)
print("# of paths: \(pathCount)")

//: [Next Day](@next)
