//
//  MealTrackerTests.swift
//  MealTrackerTests
//
//  Created by Qadriyyah Griffin on 2/20/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import XCTest
@testable import MealTracker

class MealTrackerTests: XCTestCase {

  //MARK: Meal Class Tests
  
  // Confirm that the Meal initializer returns a Meal object when passed valid parameters
  // If the initializer is working as expected, these calls should succeed.
  func testMealInitializationSucceeds() {
    
    // Zero rating
    let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
    XCTAssertNotNil(zeroRatingMeal)
    
    // Highest positive rating
    let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
    XCTAssertNotNil(positiveRatingMeal)
  }
  
  // Confirm that the Meal initializer returns nil when passed a negative rating or an empty name.
  // If the initializer is working as expected, these calls should fail.
  func testMealInitializationFails() {
    
    // Negative rating
    let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
    XCTAssertNil(negativeRatingMeal)
    
    // Rating exceeds maximum
    let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
    XCTAssertNil(largeRatingMeal)
    
    // Empty String
    let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
    XCTAssertNil(emptyStringMeal)
  }
  
}
