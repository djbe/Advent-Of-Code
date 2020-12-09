import Foundation

public struct Program {
	public var data: [Int]

	public init<T: StringProtocol>(code: [T]) {
		data = code.joined().split(separator: ",").map { Int($0) ?? 0 }
	}
}
