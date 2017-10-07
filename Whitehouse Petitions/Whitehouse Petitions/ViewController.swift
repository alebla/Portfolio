//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Alex Blanchard on 10/4/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  var petitions = [[String: String]]()

  override func viewDidLoad() {
    super.viewDidLoad()
    loadJSON()
    
    title = "Petitions"
  }
  
  //MARK: JSON Parsing
  
  func loadJSON() {
    let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    
    if let url = URL(string: urlString) {
      if let data = try? String(contentsOf: url) {
        let json = JSON.parse(data)
        
        if json["metadata"]["responseInfo"]["status"].intValue == 200 {
          parse(json: json)
        } else { showErrorAlert(title: "JSON Error", message: "Something is wrong with the json data.") }
      } else { showErrorAlert(title: "URL Error", message: "The provided url is corrupted.") }
    }else { showErrorAlert(title: "Improper String", message: "The string provided is not in proper URL format.") }
    
  }
  
  func parse(json: JSON) {
    for result in json["results"].arrayValue {
      let title = result["title"].stringValue
      let body = result["body"].stringValue
      let sigCount = result["signatureCount"].stringValue
      let sigNeeded = result["signaturesNeeded"].stringValue
      let obj = ["title": title, "body": body, "sigCount": sigCount, "sigNeeded": sigNeeded]
      
      petitions.append(obj)
    }
    tableView.reloadData()
  }
  
  //MARK: TableView Methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let petition = petitions[indexPath.row]
    cell.textLabel?.text = petition["title"]
    cell.detailTextLabel?.text = petition["body"]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
  
  //MARK: Error Handling
  
  func showErrorAlert(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
}

