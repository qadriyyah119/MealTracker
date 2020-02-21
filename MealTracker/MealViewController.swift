//
//  MealViewController.swift
//  MealTracker
//
//  Created by Qadriyyah Griffin on 2/20/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  //MARK: Properties
  
  // stores a reference and connection to text field(and other below objects) on the storyboard
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Handle the text field's user input through delegate callbacks
    nameTextField.delegate = self
  }
  
  //MARK: UITextFieldDelegate
  
  // Method returns a Bool that indicates if the system should process the press of the Return key
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Resign the textfields first responder status and Hide the keyboard
    textField.resignFirstResponder()
    return true
  }
  
  // Method gives you a chance to read the info entered in the text fiend and do something with it.
  // is called after the textfield resigns it's first responder status.
  func textFieldDidEndEditing(_ textField: UITextField) {
   
  }
  
  //MARK: UIImagePickerControllerDelegate
  
  // Method is called when user taps the image picker Cancel button and dismisses the UIImagePickerController
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismiss the picker if user canceled
    dismiss(animated: true, completion: nil)
  }
  
  // Method is called when user selects a photo and allows me to do something with image(s) that user selected from picker
  // Here we will take image and display it to image view
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // The info dictionary may contain multiple representations of the image. I want to use the original
    // This code accesses the original, unedited imag from the info dictionary and safely unwraps the optional and casts it as a UIImage object
    guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      fatalError("Expected a dictionary containing an image, but wa privided the following: \(info)")
    }
    
    // Set photoImageView to display the selected image
    photoImageView.image = selectedImage
    
    // Dismiss the picker
    dismiss(animated: true, completion: nil)
  }
  
  //MARK: Actions
  
  // IBAction indicates that the method is an action connected from the storyborad
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    //Hide keyboard if it's visable when user taps the image view
    nameTextField.resignFirstResponder()
    
    // UIImagePickerController is a view controller that lets a user pick media from their media library
    let imagePickerController = UIImagePickerController()
    
    // Only allows photos to be picked from library, not taken. .sourceType is an enum of UIImagePickerController and photoLibrary is one of it's cases
    imagePickerController.sourceType = .photoLibrary
    
    // Make sure ViewController is notified when user picks an image
    imagePickerController.delegate = self
    
    // Method being called on ViewController.
    // Asks ViewController to present the view controller defined by imagePickerController
    present(imagePickerController, animated: true, completion: nil)
  }

}

