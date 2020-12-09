//: [Previous Day](@previous)
//: # Day 3: Toboggan Trajectory

extension Grid where T == Bool {
	init<T: StringProtocol>(lines: [T]) {
		self.init(lines.map { $0.map { $0 == "#" } })
	}
}

extension Grid where T == Bool {
	func countTrees(slope: Point) -> Int {
		var result = 0

		step(from: .zero, direction: slope, wrap: true) {
			guard contains($0) else { return true }
			result += self[$0] ? 1 : 0
			return false
		}

		return result
	}
}

let grid = Grid<Bool>(lines: loadInputFile("input"))

//: ### Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?

grid.countTrees(slope: Grid.Point(x: 1, y: 1))

print("Number of trees encountered (slope 3,1): \(grid.countTrees(slope: Grid.Point(x: 3, y: 1)))")

//: ### What do you get if you multiply together the number of trees encountered on each of the listed slopes?

let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)].map(Grid.Point.init)
let result = slopes.map(grid.countTrees(slope:)).reduce(1, *)
print("Number of trees encountered (multiplied): \(result)")

//: [Next Day](@next)
