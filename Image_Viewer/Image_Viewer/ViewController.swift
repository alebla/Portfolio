//
//  ViewController.swift
//  Image_Viewer
//
//  Created by Alex Blanchard on 9/21/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Create FileManager constant that points to the Bundle directory,
    // then insert its contents into an array
    let fm    = FileManager.default
    let path  = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
    
    // Loop through items and insert pictures
    for item in items where item.hasSuffix(".jpg"){
        pictures.append(item)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

