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

	private func normal(day: Day.Type) -> Day {
		day.init(input: Advent2020.input(for: day))
	}

	func testDay01() {
		var day = normal(day: Day01.self)
		XCTAssertEqual(String(describing: day.part1()), "357504")
		XCTAssertEqual(String(describing: day.part2()), "12747392")
	}

	func testDay02() {
		var day = normal(day: Day02.self)
		XCTAssertEqual(String(describing: day.part1()), "416")
		XCTAssertEqual(String(describing: day.part2()), "688")
	}

	func testDay03() {
		var day = normal(day: Day03.self)
		XCTAssertEqual(String(describing: day.part1()), "252")
		XCTAssertEqual(String(describing: day.part2()), "2608962048")
	}

	func testDay04() {
		var day = normal(day: Day04.self)
		XCTAssertEqual(String(describing: day.part1()), "256")
		XCTAssertEqual(String(describing: day.part2()), "198")
	}

	func testDay05() {
		var day = normal(day: Day05.self)
		XCTAssertEqual(String(describing: day.part1()), "926")
		XCTAssertEqual(String(describing: day.part2()), "657")
	}

	func testDay06() {
		var day = normal(day: Day06.self)
		XCTAssertEqual(String(describing: day.part1()), "7128")
		XCTAssertEqual(String(describing: day.part2()), "3640")
	}

	func testDay07() {
		var day = normal(day: Day07.self)
		XCTAssertEqual(String(describing: day.part1()), "296")
		XCTAssertEqual(String(describing: day.part2()), "9339")
	}

	func testDay08() {
		var day = normal(day: Day08.self)
		XCTAssertEqual(String(describing: day.part1()), "1487")
		XCTAssertEqual(String(describing: day.part2()), "1607")
	}

	func testDay09() {
		var day = normal(day: Day09.self)
		XCTAssertEqual(String(describing: day.part1()), "31161678")
		XCTAssertEqual(String(describing: day.part2()), "5453868")
	}

	func testDay10() {
		var day = normal(day: Day10.self)
		XCTAssertEqual(String(describing: day.part1()), "1917")
		XCTAssertEqual(String(describing: day.part2()), "113387824750592")
	}

	func testDay11() {
		var day = normal(day: Day11.self)
		XCTAssertEqual(String(describing: day.part1()), "2412")
		XCTAssertEqual(String(describing: day.part2()), "2176")
	}

	func testDay12() {
		var day = normal(day: Day12.self)
		XCTAssertEqual(String(describing: day.part1()), "1589")
		XCTAssertEqual(String(describing: day.part2()), "23960")
	}

	func testDay13() {
		var day = normal(day: Day13.self)
		XCTAssertEqual(String(describing: day.part1()), "2545")
		XCTAssertEqual(String(describing: day.part2()), "266204454441577")
	}

	func testDay14() {
		var day = normal(day: Day14.self)
		XCTAssertEqual(String(describing: day.part1()), "6631883285184")
		XCTAssertEqual(String(describing: day.part2()), "3161838538691")
	}

	func testDay15() {
		var day = normal(day: Day15.self)
		XCTAssertEqual(String(describing: day.part1()), "496")
		XCTAssertEqual(String(describing: day.part2()), "883")
	}

	func testDay16() {
		var day = normal(day: Day16.self)
		XCTAssertEqual(String(describing: day.part1()), "19087")
		XCTAssertEqual(String(describing: day.part2()), "1382443095281")
	}

	func testDay17() {
		var day = normal(day: Day17.self)
		XCTAssertEqual(String(describing: day.part1()), "386")
		XCTAssertEqual(String(describing: day.part2()), "2276")
	}

	func testDay18() {
		var day = normal(day: Day18.self)
		XCTAssertEqual(String(describing: day.part1()), "280014646144")
		XCTAssertEqual(String(describing: day.part2()), "9966990988262")
	}

	func testDay19() {
		var day = normal(day: Day19.self)
		XCTAssertEqual(String(describing: day.part1()), "132")
		XCTAssertEqual(String(describing: day.part2()), "306")
	}

	func testDay20() {
		var day = normal(day: Day20.self)
		XCTAssertEqual(String(describing: day.part1()), "4006801655873")
		XCTAssertEqual(String(describing: day.part2()), "1838")
	}

	func testDay21() {
		var day = normal(day: Day21.self)
		XCTAssertEqual(String(describing: day.part1()), "1913")
		XCTAssertEqual(String(describing: day.part2()), "gpgrb,tjlz,gtjmd,spbxz,pfdkkzp,xcfpc,txzv,znqbr")
	}

	func testDay22() {
		var day = normal(day: Day22.self)
		XCTAssertEqual(String(describing: day.part1()), "34005")
		XCTAssertEqual(String(describing: day.part2()), "32731")
	}

	func testDay23() {
		var day = normal(day: Day23.self)
		XCTAssertEqual(String(describing: day.part1()), "34952786")
		XCTAssertEqual(String(describing: day.part2()), "505334281774")
	}

	func testDay24() {
		var day = normal(day: Day24.self)
		XCTAssertEqual(String(describing: day.part1()), "0")
		XCTAssertEqual(String(describing: day.part2()), "0")
	}

	func testDay25() {
		var day = normal(day: Day25.self)
		XCTAssertEqual(String(describing: day.part1()), "0")
		XCTAssertEqual(String(describing: day.part2()), "0")
	}
}
