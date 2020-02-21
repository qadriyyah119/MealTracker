//
//  RatingControl.swift
//  MealTracker
//
//  Created by Qadriyyah Griffin on 2/20/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
  
  //MARK: Properties
  
  // var property that contains the list of buttons
  private var ratingButtons = [UIButton]()
  
  // var property contains the control's rating
  var rating = 0 {
    // property observer
    didSet {
      updateButtonSelectionStates()
    }
  }
  
  // The following properties define the size and number of buttons in my control
  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
    //property observer - observes and responds to changes in a property's value
    // didSet is called immediately after the property values is set then calls the setupButtons method to update any changes.
    didSet {
      setupButtons()
    }
  }
  @IBInspectable var starCount: Int = 5 {
    //property observer
    didSet {
      setupButtons()
    }
  }

  //MARK: Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }
  
  //MARK: Button Action
  
  @objc func ratingButtonTapped(button: UIButton) {
    
    // The firstIndex(of:0) method finds the selected button in the array of buttons and returns the index that was found.
    // Once the buttons index is returned(a value from 0-4), we add 1 to the index to calculate the selected rating(giving a value from 1-5)
    guard let index = ratingButtons.firstIndex(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
    }
    
    //Calculate the rating of the selected button
    let selectedRating = index + 1
    
    if selectedRating == rating {
      // If the selected star represents the current rating, reset the rating to 0.
      
      rating = 0
    } else {
      // Otherwise set the rating to the selected star
      rating = selectedRating
    }
  }
  
  //MARK: Private Methods
  
  private func setupButtons() {
    
    // clear any existing buttons
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()
    
    // Load button star images from the assests catalog which is located in the app's main bundle
    let bundle = Bundle(for: type(of: self))
    let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
    let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
    let hightlightedStar = UIImage(named: "hightlightedStar", in: bundle, compatibleWith: self.traitCollection)
    
    // For-in loop that will run based on the Int value declared in starCount above, creating that # of buttons
    for index in 0..<starCount {
      // Create the button
      let button = UIButton()
      // Set the button images and their states based on user interaction
      button.setImage(emptyStar, for: .normal)
      button.setImage(filledStar, for: .selected)
      button.setImage(hightlightedStar, for: .highlighted)
      button.setImage(hightlightedStar, for: [.highlighted, .selected])
      
      // Add button constraints
      // disables the button's automatcially generated contraints. When programmatically instantiating a view this defaults to true.
      button.translatesAutoresizingMaskIntoConstraints = false
      
      // gives access to layout achors to create constraints that define the view's height and width
      // the isActive property activates or deactivates the contraint
      button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
      button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
      
      // Set the accessibility label for users with special needs
      button.accessibilityLabel = "Set \(index + 1) star rating"
      
      // Setup the button action
      // Target-Action pattern to link elements in storyboard to action methods in code. Programmatically version of IBAction attribute
      // I'm attaching the ratingButtonTapped action method to the button object, which will be triggered whenever the .touchUpInside event occurs
      button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
      
      // Add the button to the stack
      // Method adds the button created to the list of views managed by the RatingControl stack view.
      addArrangedSubview(button)
      
      // Add each new button to the ratingButtons array
      ratingButtons.append(button)
    }
    
    updateButtonSelectionStates()
  }
  
  
  private func updateButtonSelectionStates() {
    // This code iterates through the button and sets each ones selected state based on it's position and rating.
      for (index, button) in ratingButtons.enumerated() {
        // If the index of a button is less than the rating, the isSelected property is set to true, and
        // the button will be selected. The button displays the filled-in star image
        button.isSelected = index < rating
        
        //--- Accessibility code ----
        // Set the hint string for the currently selected star
        let hintString: String?
        if rating == index + 1 {
          hintString = "Tap to reset the rating to zero"
        } else {
          hintString = nil
        }
        
        // Calculate the value string
        let valueString: String
        switch (rating) {
        case 0:
          valueString = "No rating set."
        case 1:
          valueString = "1 star set."
        default:
          valueString = "\(rating) stars set."
        }
        
        // Assign the hint string and value string
        button.accessibilityHint = hintString
        button.accessibilityValue = valueString
        //--- Accessibility code end ---
        
      }
    }

}
