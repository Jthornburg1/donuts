//
//  StairwellCreator.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/7/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class StairWellCreator: UIView {
    
    let floorColors = [UIColor.floor1(), UIColor.floor11(), UIColor.floor12(), UIColor.floor13(), UIColor.floor14(), UIColor.floor15(), UIColor.floor16(), UIColor.floor17(), UIColor.floor18()]
    var rightStep = true
    var firstStaiwell = true
    var stairwell = [OneStep]()
    
    func progress(x: CGFloat, y: CGFloat, first: Bool, numberDone: Int, floorCount: Int, completion: @escaping () -> Void) {
        let firstY = self.frame.height
        let stairWidth = self.frame.width / 10
        let stairHeight = self.frame.height / 45
        let time = DispatchTime.now() + 0.1
        var count = numberDone + 1
        var newFloorCount = floorCount
        if count % 8 == 0 {
            rightStep = !rightStep
            newFloorCount = floorCount + 1
        }
        var newX = x + stairWidth
        if rightStep {
            newX = x - stairWidth
        }
        var newY = y - (stairHeight / 2)
        if first {
            newY = firstY - (stairHeight / 2)
        }
        if firstStaiwell {
            let step = OneStep()
            step.frame.size.width = stairWidth
            step.frame.size.height = stairHeight
            if floorCount < 1 {
                step.color = self.floorColors[floorCount]
            } else {
                step.color = self.floorColors[floorCount - 1]
            }
            if first {
                step.frame.origin.x = 0
                step.frame.origin.y = firstY
            } else {
                step.frame.origin.x = x
                step.frame.origin.y = y
            }
            self.addSubview(step)
            step.animateTheThing()
            self.stairwell.append(step)
        } else {
            let step = OneStep()
            step.frame.size.width = stairWidth
            step.frame.size.height = stairHeight
            if floorCount < 1 {
                step.color = self.floorColors[floorCount]
            } else {
                step.color = self.floorColors[floorCount - 1]
            }
            if first {
                step.frame.origin.x = 0
                step.frame.origin.y = firstY
            } else {
                step.frame.origin.x = x
                step.frame.origin.y = y
            }
            self.addSubview(step)
            step.animateTheThing()
            stairwell.append(step)
        }
        DispatchQueue.main.asyncAfter(deadline: time) {
            if count < 71 {
                self.progress(x: newX, y: newY, first: false, numberDone: count, floorCount: newFloorCount, completion: {
                    
                })
            } else if count == 71 {
                for step in self.stairwell {
                    step.removeFromSuperview()
                }
                self.stairwell.removeAll()
                count = -1
                newFloorCount = 0
                self.firstStaiwell = false
                self.rightStep = true
                self.progress(x: 0, y: 0, first: true, numberDone: count, floorCount: newFloorCount, completion: {
                    print("Hi There")
                })
                
            }
        }
    }
}

