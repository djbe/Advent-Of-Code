//
// Advent
// Copyright © 2020 David Jennes
//

@testable import Advent_2019
import Common
import XCTest

final class Test2019: XCTestCase, AdventTester {
	static let advent: Advent.Type = Advent2019.self

	override class func setUp() {
		logLevel = .warn
	}

	func testDay01() {
		test(day: Day01.self, input: "14") { day in
			XCTAssertEqual(String(describing: day.part1()), "2")
			XCTAssertEqual(String(describing: day.part2()), "2")
		}
		test(day: Day01.self, input: "1969") { day in
			XCTAssertEqual(String(describing: day.part1()), "654")
			XCTAssertEqual(String(describing: day.part2()), "966")
		}
		test(day: Day01.self, input: "100756") { day in
			XCTAssertEqual(String(describing: day.part1()), "33583")
			XCTAssertEqual(String(describing: day.part2()), "50346")
		}
		normal(day: Day01.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "3443395")
			XCTAssertEqual(String(describing: day.part2()), "5162216")
		}
		waitUntilDone()
	}

	func testDay02() {
		normal(day: Day02.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "4330636")
			XCTAssertEqual(String(describing: day.part2()), "6086")
		}
		waitUntilDone()
	}

	func testDay03() {
		test(day: Day03.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "6")
			XCTAssertEqual(String(describing: day.part2()), "30")
		}
		test(day: Day03.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part1()), "159")
			XCTAssertEqual(String(describing: day.part2()), "610")
		}
		test(day: Day03.self, variation: "c") { day in
			XCTAssertEqual(String(describing: day.part1()), "135")
			XCTAssertEqual(String(describing: day.part2()), "410")
		}
		normal(day: Day03.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "855")
			XCTAssertEqual(String(describing: day.part2()), "11238")
		}
		waitUntilDone()
	}

	func testDay04() {
		test(day: Day04.self, input: "000000-999999") { day in
			XCTAssertTrue(day.isValid(password: 111_111))
			XCTAssertFalse(day.isValid(password: 223_450))
			XCTAssertFalse(day.isValid(password: 123_789))
			XCTAssertTrue(day.betterIsValid(password: 112_233))
			XCTAssertFalse(day.betterIsValid(password: 123_444))
			XCTAssertTrue(day.betterIsValid(password: 111_122))
		}
		normal(day: Day04.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "460")
			XCTAssertEqual(String(describing: day.part2()), "290")
		}
		waitUntilDone()
	}

	func testDay05() {
		normal(day: Day05.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "10987514")
			XCTAssertEqual(String(describing: day.part2()), "14195011")
		}
		waitUntilDone()
	}

	func testDay06() {
		test(day: Day06.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "42")
		}
		test(day: Day06.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part2()), "4")
		}
		normal(day: Day06.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "453028")
			XCTAssertEqual(String(describing: day.part2()), "562")
		}
		waitUntilDone()
	}

	func testDay07() {
		normal(day: Day07.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "101490")
			XCTAssertEqual(String(describing: day.part2()), "61019896")
		}
		waitUntilDone()
	}

	func testDay08() {
		test(day: Day08.self, input: "0222112222120000") { day in
			day.size = [2, 2]
			XCTAssertEqual(String(describing: day.part1()), "4")
			XCTAssertEqual(String(describing: day.part2()), "TODO")
		}
		normal(day: Day08.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "2048")
			XCTAssertEqual(String(describing: day.part2()), "TODO") // "HFYAK")
		}
		waitUntilDone()
	}

	func testDay09() {
		normal(day: Day09.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "3598076521")
			XCTAssertEqual(String(describing: day.part2()), "90722")
		}
		waitUntilDone()
	}

	func testDay10() {
		test(day: Day10.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "8")
		}
		test(day: Day10.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part1()), "33")
		}
		test(day: Day10.self, variation: "c") { day in
			XCTAssertEqual(String(describing: day.part1()), "35")
		}
		test(day: Day10.self, variation: "d") { day in
			XCTAssertEqual(String(describing: day.part1()), "41")
		}
		test(day: Day10.self, variation: "e") { day in
			XCTAssertEqual(String(describing: day.part1()), "210")
			XCTAssertEqual(String(describing: day.part2()), "802")
		}
		normal(day: Day10.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "309")
			XCTAssertEqual(String(describing: day.part2()), "416")
		}
		waitUntilDone()
	}

	func testDay11() {
		normal(day: Day11.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "2322")
			XCTAssertEqual(String(describing: day.part2()), "TODO") // "JHARBGCU")
		}
		waitUntilDone()
	}

	func testDay12() {
		test(day: Day12.self, variation: "a") { day in
			day.steps = 10
			XCTAssertEqual(String(describing: day.part1()), "179")
			XCTAssertEqual(String(describing: day.part2()), "2772")
		}
		test(day: Day12.self, variation: "b") { day in
			day.steps = 100
			XCTAssertEqual(String(describing: day.part1()), "1940")
			XCTAssertEqual(String(describing: day.part2()), "4686774924")
		}
		normal(day: Day12.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "9876")
			XCTAssertEqual(String(describing: day.part2()), "307043147758488")
		}
		waitUntilDone()
	}

	func testDay13() {
		normal(day: Day13.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "284")
			XCTAssertEqual(String(describing: day.part2()), "13581")
		}
		waitUntilDone()
	}

	func testDay14() {
		test(day: Day14.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "31")
		}
		test(day: Day14.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part1()), "165")
		}
		test(day: Day14.self, variation: "c") { day in
			XCTAssertEqual(String(describing: day.part1()), "13312")
		}
		test(day: Day14.self, variation: "d") { day in
			XCTAssertEqual(String(describing: day.part1()), "180697")
			XCTAssertEqual(String(describing: day.part2()), "5586022")
		}
		test(day: Day14.self, variation: "e") { day in
			XCTAssertEqual(String(describing: day.part1()), "2210736")
			XCTAssertEqual(String(describing: day.part2()), "460664")
		}
		normal(day: Day14.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "362713")
			XCTAssertEqual(String(describing: day.part2()), "3281821")
		}
		waitUntilDone()
	}

	func testDay15() {
		normal(day: Day15.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "230")
			XCTAssertEqual(String(describing: day.part2()), "288")
		}
		waitUntilDone()
	}

	func testDay16() {
		test(day: Day16.self, input: "80871224585914546619083218645595") { day in
			XCTAssertEqual(String(describing: day.part1()), "24176176")
		}
		test(day: Day16.self, input: "19617804207202209144916044189917") { day in
			XCTAssertEqual(String(describing: day.part1()), "73745418")
		}
		test(day: Day16.self, input: "69317163492948606335995924319873") { day in
			XCTAssertEqual(String(describing: day.part1()), "52432133")
		}
		test(day: Day16.self, input: "03036732577212944063491565474664") { day in
			XCTAssertEqual(String(describing: day.part2()), "84462026")
		}
		test(day: Day16.self, input: "02935109699940807407585447034323") { day in
			XCTAssertEqual(String(describing: day.part2()), "78725270")
		}
		test(day: Day16.self, input: "03081770884921959731165446850517") { day in
			XCTAssertEqual(String(describing: day.part2()), "53553731")
		}
		normal(day: Day16.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "23135243")
			XCTAssertEqual(String(describing: day.part2()), "21130597")
		}
		waitUntilDone()
	}

	func testDay17() {
		normal(day: Day17.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "8520")
			XCTAssertEqual(String(describing: day.part2()), "926819")
		}
		waitUntilDone()
	}
}
