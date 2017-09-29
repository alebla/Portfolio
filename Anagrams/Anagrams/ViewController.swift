//
//  ViewController.swift
//  Anagrams
//
//  Created by Alex Blanchard on 9/28/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
var words = [String]()
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return words.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    
    return cell
  }
  
}

