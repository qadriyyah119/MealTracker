//
//  MealViewController.swift
//  MealTracker
//
//  Created by Qadriyyah Griffin on 2/20/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  //MARK: Properties
  
  // stores a reference and connection to text field(and other below objects) on the storyboard
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  /* This value is either passed by `MealTableViewController` in
      `prepare(for:sender:)`
    or constructed as part of adding a new meal
   */
  var meal: Meal?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Handle the text field's user input through delegate callbacks
    nameTextField.delegate = self
    
    // Enable the Save button only if the text field has a valid Meal name
    updateSaveButtonState()
  }
  
  //MARK: UITextFieldDelegate
  
  // Method returns a Bool that indicates if the system should process the press of the Return key
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Resign the textfields first responder status and Hide the keyboard
    textField.resignFirstResponder()
    return true
  }
  
  // Method gives you a chance to read the info entered in the text field and do something with it.
  // is called after the textfield resigns it's first responder status.
  func textFieldDidEndEditing(_ textField: UITextField) {
    // checks if text field has text in it, which enables Save button
    updateSaveButtonState()
    // sets the title to that text
    navigationItem.title = textField.text
  }
  
  // Method is called when editing session begins or when keyboard is displayed. It disables the Save button while user is editing
  // the text field.
  func textFieldDidBeginEditing(_ textField: UITextField) {
    //Disable the Save button while editing
    saveButton.isEnabled = false
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
  
  //MARK: Navigation
  
  // Method called when the Cancel button is presses. Dismisses the modal scene and transitions back to the previous scene, the meal list.
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  // This method lets you configure a view controller before it's presented
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    // Configure the destination view controller only when the save button is pressed.
    // Code verfies that the sender is a button, and then uses the idenitiy operator(===) to check that the objects referenced by the sender
    // and the saveButton outlet are the same
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    // The nil coalescing operator(??) is used to unwrap the optional String returned by nameTextField.text if there's a String value and if it's nil the operator will
    // return an empty string("") instead
    let name = nameTextField.text ?? ""
    let photo = photoImageView.image
    let rating = ratingControl.rating
    
    // Set the meal to be passed to MealTableViewController after the unwind segue.
    meal = Meal(name: name, photo: photo, rating: rating)
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
  
  //MARK: Private Methods
  
  // Helper method to disable the Save button if the text field is empty
  private func updateSaveButtonState() {
    // Disable the Save button if the text field is empty
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }

}

