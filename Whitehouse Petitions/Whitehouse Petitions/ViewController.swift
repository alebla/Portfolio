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
    let urlString: String
    
    if navigationController?.tabBarItem.tag == 0 {
      urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
      urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }
    
    DispatchQueue.global(.userInitiated).async { [unowned self] in
      
    }
    
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
    vc.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(vc, animated: true)
  }
  
  //MARK: Error Handling
  
  func showErrorAlert(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
  }
}

