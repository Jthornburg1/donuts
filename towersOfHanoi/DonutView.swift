//
//  DonutView.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 2/15/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class DonutView: UIView, UIGestureRecognizerDelegate {
    
    var lastLocation = CGPoint(x: 0.0, y: 0.0)
    var hole = UIView()
    var count: Int?
    var blueValue: CGFloat?
    var greenValue: CGFloat?
    var redValue: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // to initialize
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DonutView.detectPan))
        
        self.gestureRecognizers = [panRecognizer]
        
        blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
        greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
        redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        
        hole = UIView(frame: CGRect(x: (self.frame.width / 2) - 10, y: (self.frame.height / 2) - 10, width: self.frame.width / 5, height: self.frame.width / 5))
        hole.backgroundColor = UIColor.white
        hole.layer.cornerRadius = hole.frame.width / 2
        hole.clipsToBounds = true
        self.addSubview(hole)
        
        if let red = redValue, let green = greenValue, let blue = blueValue {
            self.backgroundColor = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.superview!)
        print("\(translation.x) \(translation.y)")
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // promote the touched view
        self.superview?.bringSubview(toFront: self)
        
        // remember original location
        lastLocation = self.center
    }
    
    public func setColor(color: UIColor) {
        self.backgroundColor = color
    }
}
