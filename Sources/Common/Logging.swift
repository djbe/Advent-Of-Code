//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public enum LogLevel: Int {
	case trace
	case debug
	case info
	case warn
	case error
}

public var logLevel: LogLevel = .info

public func log(_ level: LogLevel, _ message: @autoclosure () -> String) {
	guard level.rawValue >= logLevel.rawValue else { return }
	print(message())
}

public func logDay(_ day: Int, _ name: String) {
	let title = "# Day \(day): \(name) #"

	log(.info, String(repeating: "#", count: title.count))
	log(.info, title)
	log(.info, String(repeating: "#", count: title.count))
}

public func logPart(_ question: String) {
	log(.info, """

	--- \(question)

	""")
}
