//
// Advent
// Copyright © 2020 David Jennes
//

import Foundation

struct Program {
	var data: [Int]

	init<T: StringProtocol>(code: [T]) {
		data = code.joined().split(separator: ",").map { Int($0) ?? 0 }
	}
}
