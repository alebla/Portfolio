//
//  Person.swift
//  Name to Face
//
//  Created by Alex Blanchard on 10/18/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
  var name: String
  var image: String
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String
    image = aDecoder.decodeObject(forKey: "image") as! String
  }
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
  }
}
