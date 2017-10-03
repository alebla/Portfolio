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
    if let answer = answer?.lowercased() {
      // Disallow words less than 3 letters.
      if answer.count > 2 {
        if isPossible(answer) {
          if isDuplicate(answer) {
            if isReal(answer) {
              usedWords.insert(answer, at: 0)
              
              let indexPath = IndexPath(row: 0, section: 0)
              tableView.insertRows(at: [indexPath], with: .automatic)
              return  /* The following else statements set errors for the user to understand what they did wrong. */
            } else { showErrorMessage(errorTitle: "Real Fake Words", errorMessage: "The answer was not a valid word.") }
          } else { showErrorMessage(errorTitle: "Duplicate", errorMessage: "You tried that already!") }
        } else { showErrorMessage(errorTitle: "Not an anagram", errorMessage: "Try again. Letters can only be used once.") }
      } else { showErrorMessage(errorTitle: "Not Allowed", errorMessage: "Answer must be 3 letters or more") }
    } else { showErrorMessage(errorTitle: "Nil Input", errorMessage: "The input was nil.") }
  }
  
  /** Checks whether or not the users answer contains the letters inside the current word.
   - Parameters:
     - answer: Takes a String type
   - Returns: Always returns a Bool
   - Throws: Nothing expected
   */
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
  
  // Checks to see if the user used the answer already.
  func isDuplicate(_ answer: String) -> Bool {
    return !usedWords.contains(answer)
  }
  
  // Checks to see if the word is real by using the checker variable to see if the word is misspelled. If not the word is real
  // and the location will be == to the constant NSNotFound.
  func isReal(_ answer: String) -> Bool {
    let checker = UITextChecker()
    let range = NSMakeRange(0, answer.utf16.count)
    let mispelledLocation = checker.rangeOfMisspelledWord(in: answer, range: range, startingAt: 0, wrap: false, language: "en")
    return mispelledLocation.location == NSNotFound
  }
  
  // Loads the words from the imported file into allWords[].
  func populateAllWords() {
    if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
      if let startWords = try? String(contentsOfFile: startWordsPath) {
        allWords = startWords.components(separatedBy: "\n")
      }
    } else {
      allWords = ["silkworm"]
    }
  }
  
  // Builds error messages for the users incorrect responses. Responses are set in the calling function.
  func showErrorMessage(errorTitle: String, errorMessage: String) {
    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
  
  // Shuffles allWord[] and displays the current word. Emptys the tableView.
  func startGame() {
    allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
    title = allWords[0]
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
  }
  
  // MARK: TableView Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
  }
  
}

