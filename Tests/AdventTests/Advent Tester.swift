//
// Advent
// Copyright © 2020 David Jennes
//

import Common
import XCTest

protocol AdventTester: XCTestCase {
	static var advent: Advent.Type { get }
}

extension AdventTester {
	func normal<D: Day>(day: D.Type, tests: @escaping (inout D) -> Void) {
		let expectation = self.expectation(description: "\(day) - Normal")
		DispatchQueue.global().async {
			var day = day.init(input: Self.advent.input(for: day))
			tests(&day)
			expectation.fulfill()
		}
	}

	func test<D: Day>(day: D.Type, variation: String? = nil, tests: @escaping (inout D) -> Void) {
		guard let year = Self.advent.configuration.commandName else { preconditionFailure("Advent must have year (command name)") }
		let expectation = self.expectation(description: "\(day) - Test \(variation ?? "")")
		DispatchQueue.global().async {
			let input = Input(file: ["Input/\(year)/\(day)", variation].compactMap { $0 }.joined(separator: "-"), in: .module)
			var day = day.init(input: input)
			tests(&day)
			expectation.fulfill()
		}
	}

	func test<D: Day>(day: D.Type, input: String, tests: @escaping (inout D) -> Void) {
		let expectation = self.expectation(description: "\(day) - Test")
		DispatchQueue.global().async {
			var day = day.init(input: Input(input))
			tests(&day)
			expectation.fulfill()
		}
	}

	func waitUntilDone() {
		waitForExpectations(timeout: 9_999_999) { error in
			guard let error = error else { return }
			print("Error: \(error.localizedDescription)")
		}
	}
}
