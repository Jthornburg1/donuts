//
//  YelpCell.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/13/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import UIKit
import YelpAPI

class YelpCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var openClosedImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override func prepareForReuse() {
        self.placeImageView.image = UIImage(named: "placeHolder")
        self.nameLabel.text = ""
        self.addressLabel.text = ""
    }
    
    func configure(yelpItem: YLPBusiness) {
        let closedImage = UIImage(named: "closed")
        let openImage = UIImage(named: "open")
        if yelpItem.isClosed {
            openClosedImageView.image = closedImage
            openClosedImageView.tint(color: UIColor.red)
        } else {
            openClosedImageView.image = openImage
            openClosedImageView.tint(color: UIColor.green)
        }
        nameLabel.text = yelpItem.name
        let addrString = yelpItem.location.address.joined(separator: " ")
        addressLabel.text = addrString
    }
    
}
