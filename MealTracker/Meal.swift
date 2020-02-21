//
//  Meal.swift
//  MealTracker
//
//  Created by Qadriyyah Griffin on 2/20/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit

class Meal {
  
  //MARK: Properties
  
  var name: String
  var photo: UIImage?
  var rating: Int
  
  //MARK: Initialization
  
  init?(name: String, photo: UIImage?, rating: Int) {
    
    // Initialization should fail if there is no name or rating is negative
    // The name must not be empty
    guard !name.isEmpty else {
      return nil
    }
    
    // The rating must be between 0 and 5 inclusively
    guard (rating >= 0) && (rating <= 5) else {
      return nil
    }
    
    // Initialize stored properties
    self.name = name
    self.photo = photo
    self.rating = rating
  }
}
