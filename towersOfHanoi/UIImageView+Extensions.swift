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
                    let fuckedUpImage = UIImage(data: dta)
                    self.image? = (fuckedUpImage?.crop(to: self.frame.size))!
                } else {
                    let fuckedUpImage = UIImage(named: "placeHolder")
                    self.image = fuckedUpImage?.crop(to: self.frame.size)
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
    

    // Always wanted to be able to crop images...
    func crop(to: CGSize) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        
        let contextSize: CGSize = contextImage.size
        
        // Set to square
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        let cropAspect: CGFloat = to.width / to.height
        
        var cropWidth: CGFloat = to.width
        var cropHeight: CGFloat = to.height
        
        if to.width > to.height { // Landscape
            cropWidth = contextSize.width
            cropHeight = contextSize.width * cropAspect
            posY = (contextSize.width - cropHeight) / 2
        } else if to.width < to.height { // Portrait
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        } else {
            if contextSize.width >= contextSize.height { // Square on landscape (or square)
                cropHeight = contextSize.height
                cropWidth = contextSize.height * cropAspect
                posX = (contextSize.width - cropWidth) / 2
            } else {
                cropWidth = contextSize.height
                cropHeight = contextSize.width / cropAspect
                posY = (contextSize.height - cropHeight) / 2
            }
        }
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        // Create a bitmap image from context using the rect
        let imageRef = cgImage.cropping(to: rect)
        
        let cropped: UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsBeginImageContextWithOptions(to, true, self.scale)
        
        cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
        
        if let resized = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            
            return resized
            
        } else {
            
            return self
        }
    }
}
