//
//  PanTester.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/2/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class PanTester: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var nine: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var Four: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var blueView: UIView!
    
    var btnArray = [UIButton]()
    var buttonPressed: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pan Tester"
        
        btnArray = [one, two, three, Four, five, six, seven, eight, nine]
        
        blueView.alpha = 0.6
        blueView.center = CGPoint(x: 400, y: 100)
        
        let panGr = UIPanGestureRecognizer(target: self, action: #selector(PanTester.doStuff(gR:)))
        
        stack.gestureRecognizers = [panGr]
    }
    
    @IBAction func onetapped(_ sender: Any) {
        if buttonPressed != 0 {
            view.backgroundColor = UIColor.orange
            buttonPressed = 0
        }
    }
    @IBAction func fivetapped(_ sender: Any) {
        if buttonPressed != 1 {
            view.backgroundColor = UIColor.purple
            buttonPressed = 1
        }
    }
    @IBAction func twotapped(_ sender: Any) {
        if buttonPressed != 2 {
            view.backgroundColor = UIColor.lightGray
            buttonPressed = 2
        }
    }
    @IBAction func threetapped(_ sender: Any) {
        if buttonPressed != 3 {
            view.backgroundColor = UIColor.blue
            buttonPressed = 3
        }
    }
    @IBAction func fourtapped(_ sender: Any) {
        if buttonPressed != 4 {
            view.backgroundColor = UIColor.yellow
            buttonPressed = 4
        }
    }
    @IBAction func sixtapped(_ sender: Any) {
        if buttonPressed != 5 {
            view.backgroundColor = UIColor.red
            buttonPressed = 5
        }
    }
    @IBAction func seventapped(_ sender: Any) {
        if buttonPressed != 6 {
            view.backgroundColor = UIColor.green
            buttonPressed = 6
        }
       
    }
    @IBAction func eighttapped(_ sender: Any) {
        if buttonPressed != 7 {
            view.backgroundColor = UIColor.gray
            buttonPressed = 7
        }
    }
    @IBAction func ninetapped(_ sender: Any) {
        if buttonPressed != 8 {
            view.backgroundColor = UIColor.cyan
            buttonPressed = 8
        }
    }
    
    func doStuff(gR: UIPanGestureRecognizer) {
        let translation = gR.translation(in: self.view)
        var centerPnt: CGPoint?
        if gR.state == .began {
            centerPnt = gR.location(in: view)
            blueView.center = centerPnt!
        }
        blueView.center = CGPoint(x: blueView.center.x + translation.x, y: blueView.center.y + translation.y)
        gR.setTranslation(CGPoint.zero, in: view)
        
        clickButtons()
        
        print("the blue view is at \(blueView.center)")
        
        if gR.state == .ended {
            blueView.center = CGPoint(x: 440, y: 100)
        }
    }
    func clickButtons() {
        
        for button in btnArray {
            print("Frame: \(blueView.frame), ButtonCenter: \(button.center)")
            if blueView.frame.contains(CGPoint(x: button.center.x + 258, y: button.center.y + 20)) {
                button.sendActions(for: .touchUpInside)
            }
        }
    }
}
