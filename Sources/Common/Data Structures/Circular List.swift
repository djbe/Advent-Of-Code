//
//  File.swift
//
//
//  Created by David Jennes on 23/12/2020.
//

import Foundation

public final class CircularList<Element: Hashable> {
	public final class Node {
		public let value: Element
		public fileprivate(set) var previous: Node!
		public fileprivate(set) var next: Node!

		init(_ value: Element) {
			self.value = value
		}
	}

	public private(set) var first: Node?

	public init(_ values: [Element]) {
		let nodes = values.map(Node.init)
		zip(nodes, nodes.dropFirst()).forEach(Self.connect(_:to:))
		Self.connect(nodes.last, to: nodes.first)

		first = nodes.first
	}

	fileprivate static func connect(_ lhs: Node?, to rhs: Node?) {
		lhs?.next = rhs
		rhs?.previous = lhs
	}
}

public extension CircularList {
	func insert(value: Element, after node: Node) -> Node {
		let newNode = Node(value)

		let after = node.next
		Self.connect(node, to: newNode)
		Self.connect(newNode, to: after)

		return newNode
	}

	func insert(value: Element, before node: Node) -> Node {
		insert(value: value, after: node.previous)
	}

	func insert<S: Sequence>(_ sequence: S, after node: Node) where S.Element == Node {
		let after = node.next
		var first: Node?
		var last: Node?
		for item in sequence {
			first = first ?? item
			last = item
		}

		// first remove sequence from old location
		Self.connect(first?.previous, to: last?.next)

		// insert at new location
		Self.connect(node, to: first)
		Self.connect(last, to: after)
	}

	func remove(after node: Node) -> Element {
		defer {
			if first === node.next {
				first = node.next.next
			}
			Self.connect(node, to: node.next.next)
		}

		return node.next.value
	}
}

extension CircularList: Sequence {
	public struct CircularIterator: Sequence, IteratorProtocol {
		var current: Node?

		public mutating func next() -> Node? {
			defer {
				current = current?.next
			}
			return current
		}
	}

	public func makeIterator() -> CircularIterator {
		CircularIterator(current: first)
	}

	public func iterate(from value: Element) -> CircularIterator {
		let start = makeIterator().first { $0.value == value }
		return CircularIterator(current: start ?? first)
	}

	public func prefix(_ length: Int, after node: Node) -> PrefixSequence<CircularIterator> {
		CircularIterator(current: node.next).prefix(length)
	}
}
