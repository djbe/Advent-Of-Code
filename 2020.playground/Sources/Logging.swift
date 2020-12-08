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
