//: [Previous Day](@previous)
//: # Day 3: Toboggan Trajectory

struct Grid {
	let lines: [Substring]

	/// Counts the number of trees
	func traverse(slope: (x: Int, y: Int)) -> Int {
		var column = 0
		return stride(from: 0, to: lines.count, by: slope.y).reduce(into: 0) { result, row in
			result += checkValue(row: row, column: column)
			column = (column + slope.x) % lines[row].count
		}
	}

	/// `.` are empty, `#` are trees
	func checkValue(row: Int, column: Int) -> Int {
		switch lines[row][column] {
		case ".": return 0
		case "#": return 1
		default: preconditionFailure("Unknown world item '\(lines[row][column])' at (\(row), \(column))")
		}
	}
}

let grid = Grid(lines: loadInputFile("input"))

//: ### Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?

print("Number of trees encountered (slope 3,1): \(grid.traverse(slope: (3,1)))")

//: ### What do you get if you multiply together the number of trees encountered on each of the listed slopes?

let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
let result = slopes.map(grid.traverse(slope:)).reduce(1, *)
print("Number of trees encountered (multiplied): \(result)")

//: [Next Day](@next)
