//
// Advent
// Copyright © 2020 David Jennes
//

@testable import Advent_2020
import Common
import XCTest

final class Test2020: XCTestCase {
	override class func setUp() {
		logLevel = .warn
	}

	func testDay01() {
		var day = Day01()

		XCTAssertEqual(String(describing: day.part1()), "357504")
		XCTAssertEqual(String(describing: day.part2()), "12747392")
	}

	func testDay02() {
		var day = Day02()

		XCTAssertEqual(String(describing: day.part1()), "416")
		XCTAssertEqual(String(describing: day.part2()), "688")
	}

	func testDay03() {
		var day = Day03()

		XCTAssertEqual(String(describing: day.part1()), "252")
		XCTAssertEqual(String(describing: day.part2()), "2608962048")
	}

	func testDay04() {
		var day = Day04()

		XCTAssertEqual(String(describing: day.part1()), "256")
		XCTAssertEqual(String(describing: day.part2()), "198")
	}

	func testDay05() {
		var day = Day05()

		XCTAssertEqual(String(describing: day.part1()), "926")
		XCTAssertEqual(String(describing: day.part2()), "657")
	}

	func testDay06() {
		var day = Day06()

		XCTAssertEqual(String(describing: day.part1()), "7128")
		XCTAssertEqual(String(describing: day.part2()), "3640")
	}

	func testDay07() {
		var day = Day07()

		XCTAssertEqual(String(describing: day.part1()), "296")
		XCTAssertEqual(String(describing: day.part2()), "9339")
	}

	func testDay08() {
		var day = Day08()

		XCTAssertEqual(String(describing: day.part1()), "1487")
		XCTAssertEqual(String(describing: day.part2()), "1607")
	}

	func testDay09() {
		var day = Day09()

		XCTAssertEqual(String(describing: day.part1()), "31161678")
		XCTAssertEqual(String(describing: day.part2()), "5453868")
	}

	func testDay10() {
		var day = Day10()

		XCTAssertEqual(String(describing: day.part1()), "1917")
		XCTAssertEqual(String(describing: day.part2()), "113387824750592")
	}

	func testDay11() {
		var day = Day11()

		XCTAssertEqual(String(describing: day.part1()), "2412")
		XCTAssertEqual(String(describing: day.part2()), "2176")
	}

	func testDay12() {
		var day = Day12()

		XCTAssertEqual(String(describing: day.part1()), "1589")
		XCTAssertEqual(String(describing: day.part2()), "23960")
	}
}
