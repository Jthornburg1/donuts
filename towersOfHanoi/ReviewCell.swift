//
//  ReviewCell.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/14/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
