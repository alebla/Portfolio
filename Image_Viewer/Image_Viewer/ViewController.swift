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
    // iOS 11 preference
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // The name of our humble app
    title = "Image Viewer"
    
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
    // 1: try loading the "Detail" vc and typecast to a DetailViewController
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
      // 2: success! Set its selected image property
      vc.selectedImage = pictures[indexPath.row]
      
      // 3: push it onto navigation stack
      navigationController?.pushViewController(vc, animated: true)
      // 4: Allow the loaded/pushed vc to hide top bar on push
      // vc.navigationController?.hidesBarsOnTap = true ** Moved to DetailVC
    }
  }
}

