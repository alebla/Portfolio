//: Playground - noun: a place where people can play

import UIKit

// Challenge 1
func uniqueLetterStringChecker(str: String) -> Bool {
  return Set(str).count == str.count
}

uniqueLetterStringChecker(str: "AaBbCc")
uniqueLetterStringChecker(str: "AaAa")


// Challenge 2
func palindromeCheck(word: String) -> Bool {
  return String(word.lowercased().reversed()) == word.lowercased()
}

palindromeCheck(word: "Racecar")
palindromeCheck(word: "Racecars")

// Challenge 3
func uniqueLetterStringPairChecker(str1: String, str2: String) -> Bool {
  let arr1 = Array(str1.characters)
  let arr2 = Array(str2.characters)
  
  return arr1.sorted() == arr2.sorted()
}

uniqueLetterStringPairChecker(str1: "abc", str2: "cba")
uniqueLetterStringPairChecker(str1: "abc", str2: "cbAa")

// Challenge 4
extension String {
  func myContains(_ string: String) -> Bool {
    return range(of: string, options: .caseInsensitive) != nil
  }
}

"Hello World".myContains("Hello")
"Hello World".myContains("Swift is Fun!")

