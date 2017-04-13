//
//  UIImageView+Extensions.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/13/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadFrom(url: URL) {
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: { 
                if let dta = data {
                    self.image = UIImage(data: dta)
                } else {
                    self.image = UIImage(named: "placeHolder")
                }
            })
        }
        task.resume()
        
    }
    
    func tint(color: UIColor) {
        self.image = self.image?.makeTintable()
        self.tintColor = color
    }
}

extension UIImage {
    func makeTintable() -> UIImage {
        let tintableVersion = self.withRenderingMode(.alwaysTemplate)
        return tintableVersion
    }
}
