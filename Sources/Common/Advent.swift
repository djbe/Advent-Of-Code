//
// Advent
// Copyright © 2020 David Jennes
//

import ArgumentParser
import Foundation

public protocol Advent: ParsableCommand {
	static var bundle: Bundle { get }
	static var days: [Day.Type] { get }

	var day: Int { get }
}

public extension Advent {
	func validate() throws {
		guard Self.days.indices.contains(day - 1) else {
			throw ValidationError("Please specify a 'day' between 1 and \(Self.days.count - 1).")
		}
	}

	func run() {
		let input = Self.input(for: Self.days[day - 1])
		var dayProgram = Self.days[day - 1].init(input: input)

		dayProgram.run()
	}

	static func input(for day: Day.Type) -> Input {
		Input(file: String(describing: day), in: bundle)
	}
}
