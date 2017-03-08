//
//  ViewController.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 2/15/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var textF: UITextField!
    @IBOutlet weak var donutBox: UIView!
    
    var donuts: [DonutView]?
    var orderSize = 0
    var doughnut: DonutView?
    var donutCreated = false

    override func viewDidLoad() {
        super.viewDidLoad()
        textF.delegate = self
        trailing.constant = 434.0
        leading.constant = 366.0
        
        donutBox.layer.cornerRadius = 10
        donutBox.layer.borderWidth = 3
        donutBox.layer.borderColor = UIColor.darkGray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LocaButtonTapped(_ sender: Any) {
        
    }
    func makeTheDonuts() {
        let maker = CircleMaker(numberOrdered: orderSize)
        donuts = maker.fillOrder()
        var i = 0
        for donut in donuts! {
            donut.tag = i
            view.addSubview(donut)
            let push = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.pushDetail))
            push.delegate = donut
            donut.addGestureRecognizer(push)
            i += 1
        }
    }
    @IBAction func removeDonuts(_ sender: Any) {
        if let donts = donuts {
            for donut in donts {
                donut.removeFromSuperview()
            }
        }
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        textF.resignFirstResponder()
        if let num = Int(textF.text!) {
            orderSize = num
            makeTheDonuts()
            textF.text = ""
        }
    }
    func pushDetail(sender: UITapGestureRecognizer) {
        let donut = sender.view
        var i = 1
        for dont in donuts! {
            if !donutCreated {
                if dont.tag == donut!.tag {
                    let rect = CGRect(x: (donutBox.frame.width / 2) + 50, y: (donutBox.frame.height / 2) - 85, width: 170, height: 170)
                    doughnut = DonutView(frame: rect)
                    doughnut!.redValue = dont.redValue!
                    doughnut!.blueValue = dont.blueValue!
                    doughnut!.greenValue = dont.greenValue!
                    doughnut!.setColor(color: UIColor(displayP3Red: doughnut!.redValue!, green: doughnut!.greenValue!, blue: doughnut!.blueValue!, alpha: 1.0))
                    donutBox.addSubview(doughnut!)
                    colorLabel.text = "Red: \(Int(dont.redValue! * 255)), Green: \(Int(dont.greenValue! * 255)), Blue: \(Int(dont.blueValue! * 255)) !!!"
                    self.view.bringSubview(toFront: donutBox)
                    self.view.bringSubview(toFront: doughnut!)
                    animateConstraint(constraint: leading, ending: 34.0)
                    animateConstraint(constraint: trailing, ending: 34.0)
                    donutCreated = true
                    print("Making \(donut?.tag) donuts!")
                    i += 1
                }

            }
        }
    }
    @IBAction func dismissView(_ sender: Any) {
        animateConstraint(constraint: leading, ending: 434.0)
        animateConstraint(constraint: trailing, ending: 366.0)
        doughnut!.removeFromSuperview()
        doughnut = nil
        donutCreated = false
    }
    @IBAction func goToPlaces(_ sender: Any) {
        performSegue(withIdentifier: "placesSegue", sender: self)
    }
    
    func animateConstraint(constraint: NSLayoutConstraint, ending: CGFloat) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            constraint.constant = ending
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

