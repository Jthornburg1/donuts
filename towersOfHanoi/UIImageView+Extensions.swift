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
    
    func cropTo(size: CGSize) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
        
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        
        var cropWidth: CGFloat = size.width
        var cropHeight: CGFloat = size.height
        
        if (self.size.height < size.height || self.size.width < size.width) {
            return self
        }
        
        let heightPercentage = self.size.height/size.height
        let widthPercentage = self.size.width/size.width
        
        if (heightPercentage < widthPercentage) {
            cropHeight = size.height * heightPercentage
            cropWidth = size.width * heightPercentage
        } else {
            cropHeight = size.height * widthPercentage
            cropWidth = size.width * widthPercentage
        }
        
        let posX: CGFloat = (self.size.width - cropWidth) / 2
        let posY: CGFloat = (self.size.height - cropHeight) / 2
        
        let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)
        
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        
        let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return cropped
    }
}
