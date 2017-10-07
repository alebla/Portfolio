//
//  ViewController.swift
//  Tricky Little Words
//
//  Created by Alex Blanchard on 10/6/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
  @IBOutlet weak var cluesLabel: UILabel!
  @IBOutlet weak var answersLabel: UILabel!
  @IBOutlet weak var currentAnswer: UITextField!
  @IBOutlet weak var scoreLabel: UILabel!
  
  var letterButtons = [UIButton]()
  var activatedButtons = [UIButton]()
  var solutions = [String]()
  
  var score = 0
  var level = 1
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for subview in view.subviews where subview.tag == 1001 {
      let btn = subview as! UIButton
      letterButtons.append(btn)
      btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
    }
    
  }
  
  //MARK: UI Functions
  
  func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()
    
    if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
      if let levelContents = try? String(contentsOfFile: levelFilePath) {
        var lines = levelContents.components(separatedBy:"\n")
        lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
        
        for (index, line) in lines.enumerated() {
          let parts = line.components(separatedBy: ":")
          let answer = parts[0]
          let clue = parts[1]
          
          clueString += "\(index + 1). \(clue)\n"
          
          let solutionWord = answer.replacingOccurrences(of: "|", with: "")
          solutionString += "\(solutionWord.count) letters\n"
          solutions.append(solutionWord)
          
          let bits = answer.components(separatedBy: "|")
          letterBits += bits
        }
      }
    }
    // Now configure the buttons and labels
  }
  
  @objc func letterTapped(_ btn: UIButton) {
    
  }
  
  //MARK: IBActions
  
  @IBAction func submitTapped(_ sender: UIButton) {
  }
  
  @IBAction func clearTapped(_ sender: UIButton) {
  }
  
}

