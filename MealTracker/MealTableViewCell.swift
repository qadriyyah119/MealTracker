//
//  MealTableViewCell.swift
//  MealTracker
//
//  Created by Qadriyyah Griffin on 2/20/20.
//  Copyright © 2020 Qadriyyah Thomas. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
  
  //MARK: Properties
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
