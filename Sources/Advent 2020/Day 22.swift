//
// Advent
// Copyright © 2020 David Jennes
//

import Algorithms
import Common
import Foundation

private struct Game: Equatable {
	typealias Deck = [Int]
	var player1: Deck
	var player2: Deck

	init<C: Collection>(player1: C, player2: C) where C.Element == Int {
		self.player1 = Array(player1)
		self.player2 = Array(player2)
	}

	init<T: StringProtocol>(_ lines: [T]) {
		let cleaned = lines.chunked { !$1.isEmpty }.map { $0.filter { !$0.isEmpty } }
		player1 = cleaned[0].dropFirst().compactMap { Int(String($0)) }
		player2 = cleaned[1].dropFirst().compactMap { Int(String($0)) }
	}

	mutating func playRound() {
		let lhs = player1.removeFirst()
		let rhs = player2.removeFirst()
		if lhs > rhs {
			player1.append(contentsOf: [lhs, rhs])
		} else {
			player2.append(contentsOf: [rhs, lhs])
		}
	}

	var isFinished: Bool {
		player1.isEmpty || player2.isEmpty
	}

	func score(for winner: KeyPath<Game, Deck>) -> Int {
		zip(1..., self[keyPath: winner].reversed()).map(*).sum
	}
}

struct Day22: Day {
	var name: String { "Crab Combat" }

	private lazy var game = Game(loadInputFile(omittingEmptySubsequences: false))
}

// MARK: - Part 1

extension Game {
	mutating func playNormalRound() {
		let lhs = player1.removeFirst()
		let rhs = player2.removeFirst()
		if lhs > rhs {
			player1.append(contentsOf: [lhs, rhs])
		} else {
			player2.append(contentsOf: [rhs, lhs])
		}
	}
}

extension Day22 {
	mutating func part1() -> Any {
		logPart("Play the small crab in a game of Combat using the two decks you just dealt. What is the winning player's score?")

		var game = self.game
		while !game.isFinished {
			game.playNormalRound()
		}

		let winner = game.player1.isEmpty ? \Game.player2 : \.player1
		return game.score(for: winner)
	}
}

// MARK: - Part 2

extension Game {
	mutating func playRecursively() -> WritableKeyPath<Game, Deck> {
		var previousRounds: [Game] = []

		while !isFinished {
			guard !previousRounds.contains(self) else {
				return \Game.player1
			}

			previousRounds.append(self)
			playRecursiveRound()
		}

		return player1.isEmpty ? \.player2 : \.player1
	}

	mutating func playRecursiveRound() {
		let lhs = player1.removeFirst()
		let rhs = player2.removeFirst()

		let winner: WritableKeyPath<Game, Deck>
		if player1.count >= lhs, player2.count >= rhs {
			var subGame = Game(player1: player1.prefix(lhs), player2: player2.prefix(rhs))
			winner = subGame.playRecursively()
		} else {
			winner = (lhs > rhs) ? \.player1 : \.player2
		}
		let result = (winner == \.player1) ? [lhs, rhs] : [rhs, lhs]
		self[keyPath: winner].append(contentsOf: result)
	}
}

extension Day22 {
	mutating func part2() -> Any {
		logPart("Defend your honor as Raft Captain by playing the small crab in a game of Recursive Combat using the same two decks as before. What is the winning player's score?")

		var game = self.game
		let winner = game.playRecursively()

		return game.score(for: winner)
	}
}
