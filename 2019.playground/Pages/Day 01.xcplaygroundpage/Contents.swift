//: [Previous Day](@previous)
//: # Day 1: The Tyranny of the Rocket Equation

import Foundation

let input: [Int] = loadInputFile("input").compactMap { Int(String($0)) }

//: ### What is the sum of the fuel requirements for all of the modules on your spacecraft?

func fuelNeeded(for mass: Int) -> Int {
   max(Int(floor(Float(mass) / 3) - 2), 0)
}

do {
	let total = input.map(fuelNeeded(for:)).reduce(0, +)
	print("Total fuel needed: \(total)")
}

//: ### What is the sum of the fuel requirements for all of the modules on your spacecraft when also taking into account the mass of the added fuel? 


func accurateFuelNeeded(for mass: Int) -> Int {
	let fuel = fuelNeeded(for: mass)
	let extra = fuel > 0 ? accurateFuelNeeded(for: fuel) : 0
	return fuel + extra
}

do {
	let total = input.map(accurateFuelNeeded(for:)).reduce(0, +)
	print("Total fuel needed: \(total)")
}

//: [Next Day](@next)
