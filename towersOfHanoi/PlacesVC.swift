//
//  PlacesVC.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/8/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMapsCore

class PlacesVC: UIViewController {
    
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var place: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectButton.layer.cornerRadius = 22
        
    }
    @IBAction func selectAction(_ sender: Any) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        let placeFilter = GMSAutocompleteFilter()
        placeFilter.type = .city
        autoCompleteController.autocompleteFilter = placeFilter
        present(autoCompleteController, animated: true, completion: nil)
    }
    
    
}
