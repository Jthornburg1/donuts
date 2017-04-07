//
//  UIColor+Extensions.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/16/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func randomColor() -> UIColor {
        
        let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        
        let newColor = UIColor(colorLiteralRed: Float(redValue), green: Float(greenValue), blue: Float(blueValue), alpha: 1)
        
        return newColor
    }
    
    class func floor1() -> UIColor {
        return UIColor(red: 148.0/255.0, green: 150.0/255.0, blue: 153.0/255.0, alpha: 1.0)
    }
    
    class func floor11() -> UIColor {
        return UIColor(red: 252.0/255.0, green: 206.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    }
    
    class func floor12() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 164.0/255.0, blue: 9.0/255.0, alpha: 1.0)
    }
    
    class func floor13() -> UIColor {
        return UIColor(red: 238.0/255.0, green: 116.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    }
    
    class func floor14() -> UIColor {
        return UIColor(red: 252.0/255.0, green: 69.0/255.0, blue: 19.0/255.0, alpha: 1.0)
    }
    
    class func floor15() -> UIColor {
        return UIColor(red: 244.0/255.0, green: 36.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    }
    
    class func floor16() -> UIColor {
        return UIColor(red: 234.0/255.0, green: 9.0/255.0, blue: 75.0/255.0, alpha: 1.0)
    }
    
    class func floor17() -> UIColor {
        return UIColor(red: 215.0/255.0, green: 0.0/255.0, blue: 86.0/255.0, alpha: 1.0)
    }
    
    class func floor18() -> UIColor {
        return UIColor(red: 181.0/255.0, green: 3.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    }

}
