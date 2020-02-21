//
//  MealTableViewController.swift
//  MealTracker
//
//  Created by Qadriyyah Griffin on 2/20/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
  
  //MARK: Properties
  
  // declare var meals property and initialize it with an empty array of the Meals object (Meal.swift)
  var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Load the sample data.
        loadSampleMeals()
    }

    // MARK: - Table view data source
    
    // tells table how many sections to display
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    // tells table view how many rows to dsplay in a given section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //returning number of items in meals array
      return meals.count
    }

    // Configures and provides a cell to display for a given row identified by it's IndexPath(row and section). Each row in a table view has one cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIndentifier = "MealTableViewCell"
        // I'm attempting to downcast the returned object from the UITableViewCell class to my MealTableViewCell class
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? MealTableViewCell else {
        fatalError("The dequeued cell is not an instance of MealTableViewCell.")
      }
      
      // Fetches the appropriate meal for the data source layout
      let meal = meals[indexPath.row]
      
      // Sets each of the views in the table view cell to display the corresponding data from the meal object
      cell.nameLabel.text = meal.name
      cell.photoImageView.image = meal.photo
      cell.ratingControl.rating = meal.rating

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
  //MARK: Actions
  
  // I need to downcast the segue's source becauuse it's of type UIViewController and I need to work with a MealViewController
  // Then assign the MealViewController instance to the constant `sourceViewController`
  // Then checks if the meal property on sourceViewController is nil, if it's not, the value is assigned to the constant meal
  @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
      
      // Add a new meal
      let newIndexPath = IndexPath(row: meals.count, section: 0)
      
      meals.append(meal)
      tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
  }
  
  //MARK: Private Methods
  
  // helper method to load sample data into app
  private func loadSampleMeals() {
    let photo1 = UIImage(named: "meal1")
    let photo2 = UIImage(named: "meal2")
    let photo3 = UIImage(named: "meal3")
    
    // Create meal objects
    guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
      fatalError("Unable to instantiate meal1")
    }
    
    guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
      fatalError("Unable to instantiate meal1")
    }
    
    guard let meal3 = Meal(name: "Pasta with mealballs", photo: photo3, rating: 3) else {
      fatalError("Unable to instantiate meal1")
    }
    
    // add meal objects to meals array
    meals += [meal1, meal2, meal3]
  }

}
