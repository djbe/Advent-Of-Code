//: [Previous Day](@previous)
//: # Day 8: Space Image Format

import Foundation

let input = loadInputFile("input")[0]
let bytes = input.compactMap(\.wholeNumberValue)
let size = 25 * 6

//: ### find the layer that contains the fewest 0 digits. On that layer, what is the number of 1 digits multiplied by the number of 2 digits?

do {
	let layer = bytes.chunks(of: size).min { lhs, rhs in
		lhs.filter { $0 == 0 }.count < rhs.filter { $0 == 0 }.count
	} ?? []

	let ones = layer.filter { $0 == 1 }.count
	let twos = layer.filter { $0 == 2 }.count
	print("Result: \(ones * twos)")
}

//: ### What message is produced after decoding your image?

do {
	let start = Array(repeating: 2, count: size)
	let result = bytes.chunks(of: size).reduce(into: start) { current, layer in
		current = zip(current, layer).map { $0 == 2 ? $1 : $0 }
	}

	print("Message:")
	result.chunks(of: 25).forEach {
		print($0.map { $0 == 0 ? " " : "X" }.joined())
	}
}

//: [Next Day](@next)
