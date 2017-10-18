//
//  ViewController.swift
//  Name to Face
//
//  Created by Alex Blanchard on 10/16/17.
//  Copyright © 2017 Alex Blanchard. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  var people = [Person]()
  

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    
    collectionView?.backgroundColor = UIColor.cyan
    
    
    // Dummy Data
//    people = [
//      Person(name: "Bob", image: ""),
//      Person(name: "Rick", image: ""),
//      Person(name: "Bill", image: "")
//    ]
  }
  
  @objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
  }
  
  //MARK: ImagePicker Methods..
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
    
    let imageName = UUID().uuidString
    let imagePath = getsDocumentsDirectory().appendingPathComponent(imageName)
    
    if let jpegData = UIImageJPEGRepresentation(image, 80) {
      try? jpegData.write(to: imagePath)
    }
    
    let person = Person(name: "Face", image: imageName)
    people.append(person)
    collectionView?.reloadData()
    dismiss(animated: true)
  }
  
  func getsDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
  
  //MARK: CollectionView methods
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]
    
    let ac = UIAlertController(title: "Name that Face", message: "Type a name for the face", preferredStyle: .alert)
    ac.addTextField()
    
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    
    let submit = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
      person.name = ac.textFields![0].text!
      self.collectionView?.reloadData()
    }
    ac.addAction(submit)
    
    present(ac, animated: true)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return people.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as! PersonCell
    
    let person = people[indexPath.item]
    
    cell.name.text = person.name
    
    let path = getsDocumentsDirectory().appendingPathComponent(person.image)
    cell.imageView.image = UIImage(contentsOfFile: path.path)
    
    cell.imageView.layer.borderColor = UIColor.lightGray.cgColor
    cell.imageView.layer.borderWidth = 5
    cell.imageView.layer.cornerRadius = 25
    cell.imageView.clipsToBounds = true
    
    return cell
  }
}

