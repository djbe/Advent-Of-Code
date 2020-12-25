//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

public final class LinkedList<Element> {
	private final class Node {
		let value: Element
		weak var prev: Node?
		var next: Node?

		init(_ value: Element) {
			self.value = value
		}
	}

	private var head: Node?
	private var tail: Node?
	private var mutationCounter = 0
	public private(set) var count: Int = 0

	public init() {
	}

	public var underestimatedCount: Int { count }
	// swiftlint:disable:next empty_count
	public var isEmpty: Bool { count == 0 }

	private func node(at index: Int) -> Node? {
		var current = head
		var offset = 0
		while offset < index, current != nil {
			current = current?.next
			offset += 1
		}
		return current
	}
}

// MARK: - Getters

public extension LinkedList {
	var first: Element? {
		head?.value
	}

	var last: Element? {
		tail?.value
	}

	func firstIndex(where predicate: (Element) -> Bool) -> Int? {
		var current = head
		var index = 0
		while let this = current {
			if predicate(this.value) == true {
				return index
			}
			current = this.next
			index += 1
		}
		return nil
	}
}

// MARK: - Additions

public extension LinkedList {
	func append(_ value: Element) {
		insert(value, at: count)
	}

	func insert(_ value: Element, at index: Int) {
		let node = Node(value)

		if index <= 0 {
			node.next = head
			head?.prev = node
			head = node
		} else if index >= count {
			tail?.next = node
			node.prev = tail
			tail = node
		} else if let predecessor = self.node(at: index - 1) {
			let successor = predecessor.next

			node.next = successor
			node.prev = predecessor
			predecessor.next = node
			successor?.prev = node
		} else {
			fatalError("Unable to insert value at index \(index)")
		}

		if head == nil {
			head = node
		}
		count += 1
		mutationCounter += 1
	}
}

// MARK: - Subtractions

public extension LinkedList {
	func removeAll() {
		head = nil
		tail = nil
		count = 0
		mutationCounter += 1
	}

	func popFirst() -> Element? {
		guard !isEmpty else { return nil }
		return removeFirst()
	}

	func popLast() -> Element? {
		guard !isEmpty else { return nil }
		return removeLast()
	}

	func removeFirst() -> Element {
		remove(at: 0)
	}

	func removeLast() -> Element {
		remove(at: count - 1)
	}

	func remove(at index: Int) -> Element {
		guard index >= 0, index < count else { fatalError("Cannot retrieve node at index \(index)") }
		let node: Node
		if index == 0 {
			guard let head = head else { fatalError("Head should not be nil") }
			node = head
		} else if index == count - 1 {
			guard let tail = tail else { fatalError("Tail should not be nil") }
			node = tail
		} else {
			guard let item = self.node(at: index) else { fatalError("Node doesn't exist at index") }
			node = item
		}

		let value = node.value
		let prev = node.prev
		let next = node.next

		prev?.next = next
		next?.prev = prev
		if node === head { head = next }
		if node === tail { tail = prev }

		count -= 1
		mutationCounter += 1
		return value
	}
}

extension LinkedList: Sequence {
	public struct LinkedListIterator: IteratorProtocol {
		private let list: LinkedList
		private var current: Node?
		private let mutationCount: Int

		init(_ list: LinkedList) {
			self.list = list
			current = list.head
			mutationCount = list.mutationCounter
		}

		public mutating func next() -> Element? {
			assert(mutationCount == list.mutationCounter, "LinkedList mutated during iteration. This is illegal")
			defer {
				self.current = current?.next
			}
			return current?.value
		}
	}

	public func makeIterator() -> some IteratorProtocol {
		LinkedListIterator(self)
	}
}

extension LinkedList: ExpressibleByArrayLiteral {
	public convenience init(arrayLiteral elements: Element...) {
		self.init()
		elements.forEach(append)
	}
}
