//
//  HanoiPin.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/3/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class HanoiPin: UIView {
    
    override func draw(_ rect: CGRect) {
        let contextOuterCircle = UIGraphicsGetCurrentContext()
        contextOuterCircle?.setLineWidth(1)
        contextOuterCircle?.setStrokeColor(UIColor.brown.cgColor)
        let outerBox = CGRect(x: 12, y: 12, width: self.frame.width - 24, height: self.frame.height - 24)
        contextOuterCircle?.addEllipse(in: outerBox)
        contextOuterCircle?.setFillColor(UIColor.gray.cgColor)
        contextOuterCircle?.fillPath()
        contextOuterCircle?.strokePath()
        let contextMidCirc = UIGraphicsGetCurrentContext()
        let middleBox = CGRect(x: (self.frame.width / 2) - 14, y: (self.frame.height / 2) - 14, width: 28, height: 28)
        contextMidCirc?.addEllipse(in: middleBox)
        contextMidCirc?.setFillColor(UIColor.darkGray.cgColor)
        contextMidCirc?.fillPath()
        let contextInnerCirc = UIGraphicsGetCurrentContext()
        let innerBox = CGRect(x: (self.frame.width / 2) - 11, y: (self.frame.height / 2) - 11, width: 22, height: 22)
        contextInnerCirc?.addEllipse(in: innerBox)
        contextInnerCirc?.setFillColor(UIColor.black.cgColor)
        contextInnerCirc?.fillPath()
    }
}
