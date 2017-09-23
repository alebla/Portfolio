//
//  ViewController.swift
//  Guess_Who's_Flag?
//
//  Created by Alex Blanchard on 9/22/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
  @IBOutlet weak var button1: UIButton!
  
  @IBOutlet weak var button2: UIButton!
  
  @IBOutlet weak var button3: UIButton!
  
  var flags = [String]()
  var correctAnswer = 0
  var score = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    flags += ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]

    
    button1.layer.borderWidth = 3
    button2.layer.borderWidth = 2
    button3.layer.borderWidth = 2
    
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    flags = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: flags) as! [String]
    askQuestion()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func askQuestion() {
    button1.setImage(UIImage(named: flags[0]), for: .normal)
    button2.setImage(UIImage(named: flags[1]), for: .normal)
    button3.setImage(UIImage(named: flags[2]), for: .normal)
    correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
    title = "Which is \(flags[correctAnswer])'s flag?"
    
  }
  
  func shuffleFlags() {
  }
// *** Need to work on this later, A means to populating the flags by checking the bundle
//  func populateFlagsArray(flags: [String]) {
//    let fm = FileManager.default
//    let path = Bundle.main.resourcePath!
//    let items = try! fm.contentsOfDirectory(atPath: path)
//
//    for item in items where item.hasSuffix(".png"){
//      self.flags.append(item.replacingOccurrences(of: ".png", with: ""))
//    }
//  }
  
}

