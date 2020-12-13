//
// Advent
// Copyright © 2020 David Jennes
//

@testable import Advent_2019
import Common
import XCTest

final class Test2019: XCTestCase {
	override class func setUp() {
		logLevel = .warn
	}

	func testDay01() {
		var day = Day01()

		XCTAssertEqual(String(describing: day.part1()), "3443395")
		XCTAssertEqual(String(describing: day.part2()), "5162216")
	}

	func testDay02() {
		var day = Day02()

		XCTAssertEqual(String(describing: day.part1()), "4330636")
		XCTAssertEqual(String(describing: day.part2()), "6086")
	}

	func testDay03() {
		var day = Day03()

		XCTAssertEqual(String(describing: day.part1()), "855")
		XCTAssertEqual(String(describing: day.part2()), "11238")
	}

	func testDay04() {
		var day = Day04()

		XCTAssertEqual(String(describing: day.part1()), "460")
		XCTAssertEqual(String(describing: day.part2()), "290")
	}

	func testDay05() {
		var day = Day05()

		XCTAssertEqual(String(describing: day.part1()), "10987514")
		XCTAssertEqual(String(describing: day.part2()), "14195011")
	}

	func testDay06() {
		var day = Day06()

		XCTAssertEqual(String(describing: day.part1()), "453028")
		XCTAssertEqual(String(describing: day.part2()), "562")
	}

	func testDay07() {
		var day = Day07()

		XCTAssertEqual(String(describing: day.part1()), "101490")
		XCTAssertEqual(String(describing: day.part2()), "61019896")
	}

	func testDay08() {
		var day = Day08()

		XCTAssertEqual(String(describing: day.part1()), "2048")
		XCTAssertEqual(String(describing: day.part2()), "TODO") // "HFYAK")
	}

	func testDay09() {
		var day = Day09()

		XCTAssertEqual(String(describing: day.part1()), "3598076521")
		XCTAssertEqual(String(describing: day.part2()), "90722")
	}

	func testDay10() {
		var day = Day10()

		XCTAssertEqual(String(describing: day.part1()), "309")
		XCTAssertEqual(String(describing: day.part2()), "416")
	}

	func testDay11() {
		var day = Day11()

		XCTAssertEqual(String(describing: day.part1()), "2322")
		XCTAssertEqual(String(describing: day.part2()), "TODO") // "JHARBGCU")
	}

	func testDay12() {
		var day = Day12()

		XCTAssertEqual(String(describing: day.part1()), "9876")
		XCTAssertEqual(String(describing: day.part2()), "307043147758488")
	}

	func testDay13() {
		var day = Day13()

		XCTAssertEqual(String(describing: day.part1()), "284")
		XCTAssertEqual(String(describing: day.part2()), "13581")
	}

	func testDay14() {
		var day = Day14()

		XCTAssertEqual(String(describing: day.part1()), "362713")
		XCTAssertEqual(String(describing: day.part2()), "3281821")
	}

	func testDay15() {
		var day = Day15()

		XCTAssertEqual(String(describing: day.part1()), "230")
		XCTAssertEqual(String(describing: day.part2()), "288")
	}

	func testDay16() {
		var day = Day16()

		XCTAssertEqual(String(describing: day.part1()), "23135243")
		XCTAssertEqual(String(describing: day.part2()), "21130597")
	}
}
