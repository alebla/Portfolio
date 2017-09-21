//
//  ViewController.swift
//  Image_Viewer
//
//  Created by Alex Blanchard on 9/21/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
    
    for item in items {
      if item.hasPrefix("nssl") {
        // this is a picture
      }
    }
    
  }
}

