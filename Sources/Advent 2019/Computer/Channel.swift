//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

protocol Channel {
	func send(_ value: Int)
	func receive() -> Int
	func receiveLast() -> Int
	var contents: [Int] { get }
}

// MARK: - Blocking channel (with semaphores)

final class BlockingChannel: Channel {
	private var data: [Int]
	private var used: Int = 0
	private let semaphore: DispatchSemaphore
	private let queue = DispatchQueue(label: "Channel-\(UUID().uuidString)", attributes: .concurrent)

	init(data: [Int] = []) {
		self.data = data
		semaphore = .init(value: data.count)
	}

	deinit {
		// Fix playgrounds crash on release
		for _ in 0...used {
			semaphore.signal()
		}
	}

	func send(_ value: Int) {
		queue.async(flags: .barrier) {
			self.data.append(value)
		}
		semaphore.signal()
	}

	func receive() -> Int {
		var element: Int!

		semaphore.wait()
		queue.sync(flags: .barrier) {
			element = self.data.removeFirst()
			used += 1
		}

		return element
	}

	func receiveLast() -> Int {
		var element: Int!

		semaphore.wait()
		queue.sync(flags: .barrier) {
			element = self.data.removeLast()
			used += 1
		}

		return element
	}

	var contents: [Int] {
		var result: [Int] = []

		queue.sync(flags: .barrier) {
			result = self.data
		}

		return result
	}
}

extension BlockingChannel {
	convenience init(_ data: Int...) {
		self.init(data: data)
	}
}

// MARK: - Callback channel

final class CallbackChannel: Channel {
	private let generator: (() -> Int)?
	private let receiver: (([Int]) -> Void)?
	private var receivedData: [Int] = []
	private let receiverChunkSize: Int

	init(generator: (() -> Int)? = nil, receiver: (([Int]) -> Void)? = nil, chunkedBy receiverChunkSize: Int) {
		self.generator = generator
		self.receiver = receiver
		self.receiverChunkSize = receiverChunkSize
	}

	func send(_ value: Int) {
		guard let receiver = receiver else { fatalError("Need receiver callback!") }
		receivedData.append(value)
		if receivedData.count == receiverChunkSize {
			receiver(receivedData)
			receivedData = []
		}
	}

	func receive() -> Int {
		guard let generator = generator else { fatalError("Need generator callback!") }
		return generator()
	}

	func receiveLast() -> Int {
		guard let generator = generator else { fatalError("Need generator callback!") }
		return generator()
	}

	var contents: [Int] {
		guard let generator = generator else { fatalError("Need generator callback!") }
		return [generator()]
	}
}

extension CallbackChannel {
	convenience init(generator: (() -> Int)? = nil, receiver: ((Int) -> Void)? = nil) {
		let wrappedReceiver: (([Int]) -> Void)? = receiver.map { callback in { callback($0[0]) } }
		self.init(generator: generator, receiver: wrappedReceiver, chunkedBy: 1)
	}
}
