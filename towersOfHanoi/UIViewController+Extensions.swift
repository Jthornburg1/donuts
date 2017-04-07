//
//  UIViewController+Extensions.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/8/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit
import GoogleMapsCore
import GooglePlaces
import GoogleMaps

extension PlacesVC: GMSAutocompleteViewControllerDelegate {
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.place = place
        if let address = place.formattedAddress {
            let addressArray = address.components(separatedBy: ", ")
            if addressArray.count == 3 {
                self.cityLabel.text = addressArray[0]
                self.stateLabel.text = addressArray[1]
                self.countryLabel.text = addressArray[2]
            } else {
                self.cityLabel.text = addressArray[0]
                self.countryLabel.text = addressArray[1]
                self.stateLabel.text = "...foreign country..."
            }
            self.longitude.text = String(describing: place.coordinate.longitude)
            self.latitude.text = String(describing: place.coordinate.latitude)
        }
        dismiss(animated: true, completion: nil)
    }
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }
    
    public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
