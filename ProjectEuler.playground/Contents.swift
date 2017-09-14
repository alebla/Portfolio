// The following functions are answers to the problems presented on
// the project euler website.

import UIKit

// Problem 1: If we list all the natural numbers below 10 that are multiples
// of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
// Find the sum of all the multiples of 3 or 5 below 1000.

func multiplesOf3And5() -> Int {
  var result = 0
  for x in 1..<1000  {
    if x % 3 == 0 || x % 5 == 0 {
      result += x
    }
  }
  return result
}
let problem1Answer = multiplesOf3And5()

