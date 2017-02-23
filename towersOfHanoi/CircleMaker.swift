//
//  CircleMaker.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 2/15/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

struct CircleMaker {
    
    var numberOrdered = 0
    
    func create1() -> DonutView {
        
        let x = CGFloat(Int(arc4random() % 320))
        let y = CGFloat(Int(arc4random() % 600))
        let donut = DonutView(frame: CGRect(x: x, y: y, width: 60, height: 60))
        return donut
    }
    
    func fillOrder() -> [DonutView] {
        var order = [DonutView]()
        for n in 0...numberOrdered - 1 {
            let newD = create1()
            order.append(newD)
        }
        return order
    }
}
