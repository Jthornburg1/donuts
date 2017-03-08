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
        print("place name: \(place.name)")
        print("place address: \(place.formattedAddress)")
        print("place attributions: \(place.attributions)")
    }
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }
    
    public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
