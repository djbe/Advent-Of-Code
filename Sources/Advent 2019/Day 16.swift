//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

struct FFT {
	let pattern = [0, 1, 0, -1]

	func coefficient(at index: Int, row: Int) -> Int {
		pattern[((index + 1) / (row + 1)) % pattern.count]
	}

	func apply(input: [Int], output: inout [Int], offset: Int = 0) {
		for index in 0..<input.count {
			output[index] = abs(zip(0..., input).map { coefficient(at: $0, row: index) * $1 }.sum) % 10
		}
	}
}

struct Day16: Day {
	var name: String { "Flawed Frequency Transmission" }

	private lazy var numbers = loadInputFile()[0].compactMap { Int(String($0)) }
}

// MARK: - Part 1

extension Day16 {
	mutating func part1() -> Any {
		logPart("After 100 phases of FFT, what are the first eight digits in the final output list?")

		let fft = FFT()
		var numbers = self.numbers
		var temp = Array(repeating: 0, count: numbers.count)
		for _ in 1...100 {
			fft.apply(input: numbers, output: &temp)
			swap(&numbers, &temp)
		}

		return numbers.prefix(8).map(String.init).joined()
	}
}

// MARK: - Part 2

extension FFT {
	func apply(input: [Int], output: inout [Int], offset: Int, length: Int) {
		guard offset > length / 2 else { return apply(input: input, output: &output) }

		// once we're over the halfway point, all coefficients from here are 1
		// so for the first digit: sum everything
		// for the 2nd digit: sum everything (except the first)
		// and so on...

		var sum = 0
		for index in (0..<input.count).reversed() {
			sum = (sum + input[index]) % 10
			output[index] = sum
		}
	}
}

extension Day16 {
	mutating func part2() -> Any {
		logPart("After repeating your input signal 10000 times and running 100 phases of FFT, what is the eight-digit message embedded in the final output list?")

		let offset = Int(self.numbers.prefix(7).map(String.init).joined()) ?? 0
		let length = self.numbers.count * 10_000
		var numbers = Array(Array(repeating: self.numbers, count: 10_000).flatMap { $0 }.dropFirst(offset))

		let fft = FFT()
		var temp = Array(repeating: 0, count: numbers.count)
		for _ in 1...100 {
			fft.apply(input: numbers, output: &temp, offset: offset, length: length)
			swap(&numbers, &temp)
		}

		return numbers.prefix(8).map(String.init).joined()
	}
}
