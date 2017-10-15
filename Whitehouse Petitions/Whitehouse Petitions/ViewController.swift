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
    performSelector(inBackground: #selector(loadJSON), with: nil)
    
    title = "Petitions"
  }
  
  //MARK: JSON Parsing
  
  @objc func loadJSON() {
    let urlString: String
    
    if navigationController?.tabBarItem.tag == 0 {
      urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
      urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }
    
    if let url = URL(string: urlString) {
      if let data = try? String(contentsOf: url) {
        let json = JSON.parse(data)
        
        if json["metadata"]["responseInfo"]["status"].intValue == 200 {
          self.parse(json: json)
          return
        }
      }
    }
    performSelector(onMainThread: #selector(showErrorAlert(title:message:)), with: nil, waitUntilDone: false)
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
    tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
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
  // to do!! Does not show a title or message
  @objc func showErrorAlert(title: String, message: String) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(ac, animated: true)
  }
}

