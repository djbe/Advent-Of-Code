//
// Advent
// Copyright © 2020 David Jennes
//

import Common

struct Program {
	var data: [Int]

	init<T: StringProtocol>(code: [Line<T>]) {
		data = code.map(\.csvIntegers).flatMap { $0 }
	}
}
