//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

final class Channel<T> {
	private var data: [T]
	private var used: Int = 0
	private let semaphore: DispatchSemaphore
	private let queue = DispatchQueue(label: "Channel-\(UUID().uuidString)", attributes: .concurrent)

	init(data: [T] = []) {
		self.data = data
		semaphore = .init(value: data.count)
	}

	deinit {
		// Fix playgrounds crash on release
		for _ in 0...used {
			semaphore.signal()
		}
	}

	func send(_ value: T) {
		queue.async(flags: .barrier) {
			self.data.append(value)
		}
		semaphore.signal()
	}

	func receive() -> T? {
		var element: T?

		semaphore.wait()
		queue.sync(flags: .barrier) {
			element = self.data.removeFirst()
			used += 1
		}

		return element
	}

	func receiveLast() -> T {
		var element: T!

		semaphore.wait()
		queue.sync(flags: .barrier) {
			element = self.data.removeLast()
			used += 1
		}

		return element
	}

	var contents: [T] {
		var result: [T] = []

		queue.sync(flags: .barrier) {
			result = self.data
		}

		return result
	}
}

extension Channel {
	convenience init(_ data: T...) {
		self.init(data: data)
	}
}
