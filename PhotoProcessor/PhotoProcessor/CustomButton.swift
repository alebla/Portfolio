//
//  CustomButton.swift
//  PhotoProcessor
//
//  Created by Alex Blanchard on 10/23/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import Foundation
import UIKit

public class CustomBtn: UIButton {
  
//  @IBInspectable var cornerRadius: CGFloat = 0.0 {
//    didSet {
//      layer.cornerRadius = cornerRadius
//      layer.masksToBounds = cornerRadius > 0
//    }
//  }
//
//  @IBInspectable var borderWidth: CGFloat = 0 {
//    didSet {
//      layer.borderWidth = borderWidth
//    }
//  }
//
//  @IBInspectable var borderColor: UIColor? {
//    didSet {
//      layer.borderColor = borderColor?.cgColor
//    }
//  }
//
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let btn = self
    
    btn.layer.cornerRadius = 5
    btn.layer.borderWidth = 2
    btn.layer.borderColor = UIColor.darkGray.cgColor
    
    
    
  }
}
