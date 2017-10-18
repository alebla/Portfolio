//
//  Person.swift
//  Name to Face
//
//  Created by Alex Blanchard on 10/18/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class Person: NSObject{
  var name: String
  var image: String
  
  
  init(name: String, image: String) {
    self.name = name
    self.image = image
  }
}
