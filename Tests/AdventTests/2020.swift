//
// Advent
// Copyright © 2020 David Jennes
//

@testable import Advent_2020
import Common
import XCTest

// swiftlint:disable file_length type_body_length

final class Test2020: XCTestCase, AdventTester {
	static let advent: Advent.Type = Advent2020.self

	override class func setUp() {
		logLevel = .warn
	}

	func testDay01() {
		test(day: Day01.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "514579")
			XCTAssertEqual(String(describing: day.part2()), "241861950")
		}
		normal(day: Day01.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "357504")
			XCTAssertEqual(String(describing: day.part2()), "12747392")
		}
		waitUntilDone()
	}

	func testDay02() {
		test(day: Day02.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "2")
			XCTAssertEqual(String(describing: day.part2()), "1")
		}
		normal(day: Day02.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "416")
			XCTAssertEqual(String(describing: day.part2()), "688")
		}
		waitUntilDone()
	}

	func testDay03() {
		test(day: Day03.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "7")
			XCTAssertEqual(String(describing: day.part2()), "336")
		}
		normal(day: Day03.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "252")
			XCTAssertEqual(String(describing: day.part2()), "2608962048")
		}
		waitUntilDone()
	}

	func testDay04() {
		test(day: Day04.self, variation: "part1") { day in
			XCTAssertEqual(String(describing: day.part1()), "2")
		}
		test(day: Day04.self, variation: "invalid") { day in
			XCTAssertEqual(String(describing: day.part2()), "0")
		}
		test(day: Day04.self, variation: "valid") { day in
			XCTAssertEqual(String(describing: day.part2()), "4")
		}
		normal(day: Day04.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "256")
			XCTAssertEqual(String(describing: day.part2()), "198")
		}
		waitUntilDone()
	}

	func testDay05() {
		test(day: Day05.self, input: "FBFBBFFRLR") { day in
			XCTAssertEqual(String(describing: day.part1()), "357")
		}
		test(day: Day05.self, input: "BFFFBBFRRR") { day in
			XCTAssertEqual(String(describing: day.part1()), "567")
		}
		test(day: Day05.self, input: "FFFBBBFRRR") { day in
			XCTAssertEqual(String(describing: day.part1()), "119")
		}
		test(day: Day05.self, input: "BBFFBBFRLL") { day in
			XCTAssertEqual(String(describing: day.part1()), "820")
		}
		normal(day: Day05.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "926")
			XCTAssertEqual(String(describing: day.part2()), "657")
		}
		waitUntilDone()
	}

	func testDay06() {
		test(day: Day06.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "11")
			XCTAssertEqual(String(describing: day.part2()), "6")
		}
		normal(day: Day06.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "7128")
			XCTAssertEqual(String(describing: day.part2()), "3640")
		}
		waitUntilDone()
	}

	func testDay07() {
		test(day: Day07.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "4")
			XCTAssertEqual(String(describing: day.part2()), "32")
		}
		test(day: Day07.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part2()), "126")
		}
		normal(day: Day07.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "296")
			XCTAssertEqual(String(describing: day.part2()), "9339")
		}
		waitUntilDone()
	}

	func testDay08() {
		test(day: Day08.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "5")
			XCTAssertEqual(String(describing: day.part2()), "8")
		}
		normal(day: Day08.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "1487")
			XCTAssertEqual(String(describing: day.part2()), "1607")
		}
		waitUntilDone()
	}

	func testDay09() {
		test(day: Day09.self) { day in
			day.preamble = 5
			XCTAssertEqual(String(describing: day.part1()), "127")
			XCTAssertEqual(String(describing: day.part2()), "62")
		}
		normal(day: Day09.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "31161678")
			XCTAssertEqual(String(describing: day.part2()), "5453868")
		}
		waitUntilDone()
	}

	func testDay10() {
		test(day: Day10.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "\(7 * 5)")
			XCTAssertEqual(String(describing: day.part2()), "8")
		}
		test(day: Day10.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part1()), "\(22 * 10)")
			XCTAssertEqual(String(describing: day.part2()), "19208")
		}
		normal(day: Day10.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "1917")
			XCTAssertEqual(String(describing: day.part2()), "113387824750592")
		}
		waitUntilDone()
	}

	func testDay11() {
		test(day: Day11.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "37")
			XCTAssertEqual(String(describing: day.part2()), "26")
		}
		normal(day: Day11.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "2412")
			XCTAssertEqual(String(describing: day.part2()), "2176")
		}
		waitUntilDone()
	}

	func testDay12() {
		test(day: Day12.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "25")
			XCTAssertEqual(String(describing: day.part2()), "286")
		}
		normal(day: Day12.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "1589")
			XCTAssertEqual(String(describing: day.part2()), "23960")
		}
		waitUntilDone()
	}

	func testDay13() {
		test(day: Day13.self, input: "939\n7,13,x,x,59,x,31,19") { day in
			XCTAssertEqual(String(describing: day.part1()), "295")
			XCTAssertEqual(String(describing: day.part2()), "1068781")
		}
		test(day: Day13.self, input: "939\n17,x,13,19") { day in
			XCTAssertEqual(String(describing: day.part2()), "3417")
		}
		test(day: Day13.self, input: "939\n67,7,59,61") { day in
			XCTAssertEqual(String(describing: day.part2()), "754018")
		}
		test(day: Day13.self, input: "939\n67,x,7,59,61") { day in
			XCTAssertEqual(String(describing: day.part2()), "779210")
		}
		test(day: Day13.self, input: "939\n67,7,x,59,61") { day in
			XCTAssertEqual(String(describing: day.part2()), "1261476")
		}
		test(day: Day13.self, input: "939\n1789,37,47,1889") { day in
			XCTAssertEqual(String(describing: day.part2()), "1202161486")
		}
		normal(day: Day13.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "2545")
			XCTAssertEqual(String(describing: day.part2()), "266204454441577")
		}
		waitUntilDone()
	}

	func testDay14() {
		test(day: Day14.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "165")
		}
		test(day: Day14.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part2()), "208")
		}
		normal(day: Day14.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "6631883285184")
			XCTAssertEqual(String(describing: day.part2()), "3161838538691")
		}
		waitUntilDone()
	}

	func testDay15() {
		test(day: Day15.self, input: "0,3,6") { day in
			XCTAssertEqual(String(describing: day.part1()), "436")
			XCTAssertEqual(String(describing: day.part2()), "175594")
		}
		test(day: Day15.self, input: "1,3,2") { day in
			XCTAssertEqual(String(describing: day.part1()), "1")
			XCTAssertEqual(String(describing: day.part2()), "2578")
		}
		test(day: Day15.self, input: "2,1,3") { day in
			XCTAssertEqual(String(describing: day.part1()), "10")
			XCTAssertEqual(String(describing: day.part2()), "3544142")
		}
		test(day: Day15.self, input: "1,2,3") { day in
			XCTAssertEqual(String(describing: day.part1()), "27")
			XCTAssertEqual(String(describing: day.part2()), "261214")
		}
		test(day: Day15.self, input: "2,3,1") { day in
			XCTAssertEqual(String(describing: day.part1()), "78")
			XCTAssertEqual(String(describing: day.part2()), "6895259")
		}
		test(day: Day15.self, input: "3,2,1") { day in
			XCTAssertEqual(String(describing: day.part1()), "438")
			XCTAssertEqual(String(describing: day.part2()), "18")
		}
		test(day: Day15.self, input: "3,1,2") { day in
			XCTAssertEqual(String(describing: day.part1()), "1836")
			XCTAssertEqual(String(describing: day.part2()), "362")
		}
		normal(day: Day15.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "496")
			XCTAssertEqual(String(describing: day.part2()), "883")
		}
		waitUntilDone()
	}

	func testDay16() {
		test(day: Day16.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "71")
		}
		test(day: Day16.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part2()), "12")
		}
		normal(day: Day16.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "19087")
			XCTAssertEqual(String(describing: day.part2()), "1382443095281")
		}
		waitUntilDone()
	}

	func testDay17() {
		test(day: Day17.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "112")
			XCTAssertEqual(String(describing: day.part2()), "848")
		}
		normal(day: Day17.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "386")
			XCTAssertEqual(String(describing: day.part2()), "2276")
		}
		waitUntilDone()
	}

	func testDay18() {
		test(day: Day18.self, input: "1 + 2 * 3 + 4 * 5 + 6") { day in
			XCTAssertEqual(String(describing: day.part1()), "71")
			XCTAssertEqual(String(describing: day.part2()), "231")
		}
		test(day: Day18.self, input: "1 + (2 * 3) + (4 * (5 + 6))") { day in
			XCTAssertEqual(String(describing: day.part1()), "51")
			XCTAssertEqual(String(describing: day.part2()), "51")
		}
		test(day: Day18.self, input: "2 * 3 + (4 * 5)") { day in
			XCTAssertEqual(String(describing: day.part1()), "26")
			XCTAssertEqual(String(describing: day.part2()), "46")
		}
		test(day: Day18.self, input: "5 + (8 * 3 + 9 + 3 * 4 * 3)") { day in
			XCTAssertEqual(String(describing: day.part1()), "437")
			XCTAssertEqual(String(describing: day.part2()), "1445")
		}
		test(day: Day18.self, input: "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") { day in
			XCTAssertEqual(String(describing: day.part1()), "12240")
			XCTAssertEqual(String(describing: day.part2()), "669060")
		}
		test(day: Day18.self, input: "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") { day in
			XCTAssertEqual(String(describing: day.part1()), "13632")
			XCTAssertEqual(String(describing: day.part2()), "23340")
		}
		normal(day: Day18.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "280014646144")
			XCTAssertEqual(String(describing: day.part2()), "9966990988262")
		}
		waitUntilDone()
	}

	func testDay19() {
		test(day: Day19.self, variation: "a") { day in
			XCTAssertEqual(String(describing: day.part1()), "2")
		}
		test(day: Day19.self, variation: "b") { day in
			XCTAssertEqual(String(describing: day.part2()), "12")
		}
		normal(day: Day19.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "132")
			XCTAssertEqual(String(describing: day.part2()), "306")
		}
		waitUntilDone()
	}

	func testDay20() {
		test(day: Day20.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "20899048083289")
			XCTAssertEqual(String(describing: day.part2()), "273")
		}
		normal(day: Day20.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "4006801655873")
			XCTAssertEqual(String(describing: day.part2()), "1838")
		}
		waitUntilDone()
	}

	func testDay21() {
		test(day: Day21.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "5")
			XCTAssertEqual(String(describing: day.part2()), "mxmxvkd,sqjhc,fvjkl")
		}
		normal(day: Day21.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "1913")
			XCTAssertEqual(String(describing: day.part2()), "gpgrb,tjlz,gtjmd,spbxz,pfdkkzp,xcfpc,txzv,znqbr")
		}
		waitUntilDone()
	}

	func testDay22() {
		test(day: Day22.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "306")
			XCTAssertEqual(String(describing: day.part2()), "291")
		}
		normal(day: Day22.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "34005")
			XCTAssertEqual(String(describing: day.part2()), "32731")
		}
		waitUntilDone()
	}

	func testDay23() {
		test(day: Day23.self, input: "389125467") { day in
			XCTAssertEqual(String(describing: day.part1()), "67384529")
			XCTAssertEqual(String(describing: day.part2()), "149245887792")
		}
		normal(day: Day23.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "34952786")
			XCTAssertEqual(String(describing: day.part2()), "505334281774")
		}
		waitUntilDone()
	}

	func testDay24() {
		test(day: Day24.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "10")
			XCTAssertEqual(String(describing: day.part2()), "2208")
		}
		normal(day: Day24.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "438")
			XCTAssertEqual(String(describing: day.part2()), "4038")
		}
		waitUntilDone()
	}

	func testDay25() {
		test(day: Day25.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "0")
			XCTAssertEqual(String(describing: day.part2()), "0")
		}
		normal(day: Day25.self) { day in
			XCTAssertEqual(String(describing: day.part1()), "0")
			XCTAssertEqual(String(describing: day.part2()), "0")
		}
		waitUntilDone()
	}
}
