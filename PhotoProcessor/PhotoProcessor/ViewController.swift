//
//  ViewController.swift
//  PhotoProcessor
//
//  Created by Alex Blanchard on 10/22/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var intensity: UISlider!
  @IBOutlet weak var imageView: UIImageView!
  
  var currentImage: UIImage!
  
  var context: CIContext!
  var currentFilter: CIFilter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
  
  func buildUI() {
    title = "Photo Processor"
    navigationController?.navigationBar.barStyle = .blackTranslucent
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 5
    imageView.layer.borderWidth = 3
    imageView.layer.borderColor = UIColor.white.cgColor
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    
    context = CIContext()
    currentFilter = CIFilter(name: "CISepiaTone")
  }
  
  @objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  //MARK: Picker Methods
  
  @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { print("Failed"); return }
    
    currentImage = image
    
    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    
    applyProcessing()
    
    dismiss(animated: true)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  //MARK: Filter methods
  
  func applyProcessing() {
    currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
    
    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
      let processedImage = UIImage(cgImage: cgimg)
      imageView.image = processedImage
    } else {
      print("No picture!")
    }
  }
  
  func setFilter(action: UIAlertAction) {
    guard currentImage != nil else { return }
    currentFilter = CIFilter(name: action.title!)
    currentFilter.setValue(CIImage(image: currentImage), forKey: kCIInputImageKey)
    applyProcessing()
  }
  
  func saveImage() {
    guard imageView.image != nil else { return }
    UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    
  }
  
  //MARK: IBActions
  
  @IBAction func saveImage(_ sender: UIButton) {
    saveImage()
  }
  
  @IBAction func changeFilter(_ sender: UIButton) {
    let ac = UIAlertController(title: "Choose Filter", message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
  }
  
  @IBAction func intensityChanged(_ sender: UISlider) {
    if imageView.image == nil { return }
    applyProcessing()
  }
  
  
  
  
  
  
  
}

