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
      self.submitAnswer(answer.text)
    }
    ac.addAction(submitAction)
    present(ac, animated: true)
  }
  
  func submitAnswer(_ answer: String?) {
    
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

