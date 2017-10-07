//
//  ViewController.swift
//  Tricky Little Words
//
//  Created by Alex Blanchard on 10/6/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

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
  }
  
  //MARK: IBActions
  
  @IBAction func submitTapped(_ sender: UIButton) {
  }
  
  @IBAction func clearTapped(_ sender: UIButton) {
  }
  
}

