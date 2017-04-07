//
//  OneStep.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/7/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class OneStep: UIView {
    
    var stepLayer = CAShapeLayer()
    var maskLayer = CAShapeLayer()
    var stepPath = UIBezierPath()
    var color = UIColor()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = UIColor.clear
        
        stepPath = UIBezierPath(ovalIn: bounds)
        
        stepLayer.path = stepPath.cgPath
        stepLayer.strokeColor = UIColor.black.cgColor
        stepLayer.fillColor = color.cgColor
        layer.addSublayer(stepLayer)
    }
    
    func animateTheThing() {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.5
        animation.toValue = UIBezierPath(rect: bounds).cgPath
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        stepLayer.add(animation, forKey: nil)
    }
    
}
