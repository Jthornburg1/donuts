//
//  DonutView.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 2/15/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class DonutView: UIView {
    
    var lastLocation = CGPoint(x: 0.0, y: 0.0)
    var hole = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // to initialize
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DonutView.detectPan))
        
        self.gestureRecognizers = [panRecognizer]
        
        let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        
        hole = UIView(frame: CGRect(x: (self.frame.width / 2) - 10, y: (self.frame.height / 2) - 10, width: 20.0, height: 20.0))
        hole.backgroundColor = UIColor.white
        hole.layer.cornerRadius = 10
        hole.clipsToBounds = true
        self.addSubview(hole)
        
        self.backgroundColor = UIColor(displayP3Red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.superview!)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // promote the touched view
        self.superview?.bringSubview(toFront: self)
        
        // remember original location
        lastLocation = self.center
    }
}
