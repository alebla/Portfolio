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
    populateAllWords()
    startGame()
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
    return allWords.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = allWords[indexPath.row]
    return cell
  }
  
}
