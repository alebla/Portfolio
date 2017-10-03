//
//  ViewController.swift
//  Anagrams
//
//  Created by Alex Blanchard on 9/28/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
  var allWords = [String]()
  var usedWords = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
    populateAllWords()
    startGame()
  }
  
  func buildUI() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
  }
  
  @objc func promptForAnswer() {
    let ac = UIAlertController(title: "Make a word", message: nil, preferredStyle: .alert)
    ac.addTextField(configurationHandler: nil)
    
    let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction) in
      let answer = ac.textFields![0]
      self.submit(answer.text)
    }
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  func submit(_ answer: String?) {
    let errorTitle: String
    let errorMessage: String
    
    if let answer = answer?.lowercased() {
      // Disallow words less than 3 letters
      if answer.count > 2 {
        if isPossible(answer) {
          if isDuplicate(answer) {
            if isReal(answer) {
              usedWords.insert(answer, at: 0)
              
              let indexPath = IndexPath(row: 0, section: 0)
              tableView.insertRows(at: [indexPath], with: .automatic)
              return
            } else {
              errorTitle   = "Real Fake Words"
              errorMessage = "The answer was not a valid word."
            }
          } else {
            errorTitle   = "Duplicate"
            errorMessage = "You tried that already!"
          }
        } else {
          errorTitle   = "Not an anagram"
          errorMessage = "Try again. Remeber, letters can only be used once."
        }
      } else {
        errorTitle = "Not Allowed"
        errorMessage = "Answer must not be shorter than 3 letters"
      }
    } else {
      errorTitle   = "Nil Input"
      errorMessage = "The input was nil."
    }
    
    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  func isPossible(_ answer: String) -> Bool {
    var tempWord = title!.lowercased()
    
    for letter in answer {
      if let pos = tempWord.range(of: String(letter)) {
        tempWord.remove(at: pos.lowerBound)
      } else {
        return false
      }
    }
    return true
  }
  
  func isDuplicate(_ answer: String) -> Bool {
    return !usedWords.contains(answer)
  }
  
  func isReal(_ answer: String) -> Bool {
    let checker = UITextChecker()
    let range = NSMakeRange(0, answer.utf16.count)
    let mispelledLocation = checker.rangeOfMisspelledWord(in: answer, range: range, startingAt: 0, wrap: false, language: "en")
    return mispelledLocation.location == NSNotFound
  }
  
  func populateAllWords() {
    if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
      if let startWords = try? String(contentsOfFile: startWordsPath) {
        allWords = startWords.components(separatedBy: "\n")
      }
    } else {
      allWords = ["silkworm"]
    }
  }
  
  func startGame() {
    allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
    title = allWords[0]
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
  }
  
}

