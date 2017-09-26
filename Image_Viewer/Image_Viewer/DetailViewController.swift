//
//  DetailViewController.swift
//  Image_Viewer
//
//  Created by Alex Blanchard on 9/21/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  var selectedImage: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    
    
    if let image = selectedImage {
      title = image
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
      imageView.image = UIImage(named: image)
    }
  }
  
  @objc func shareTapped() {
    let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  // iPhone X 
//  override func prefersHomeIndicatorAutoHidden() -> Bool {
//    return navigationController!.hidesBarsOnTap
//  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
