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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let num = Int(textField.text!) {
            orderSize = num
            makeTheDonuts()
            textField.text = ""
        }
        return true
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
    
    func pushDetail(sender: UITapGestureRecognizer) {
        let donut = sender.view
        for dont in donuts! {
            if dont.tag == donut!.tag {
                let rect = CGRect(x: (donutBox.frame.width / 2) - 60, y: (donutBox.frame.height / 2) - 60, width: 120, height: 120)
                doughnut = DonutView(frame: rect)
                doughnut!.redValue = dont.redValue!
                doughnut!.blueValue = dont.blueValue!
                doughnut!.greenValue = dont.greenValue!
                colorLabel.text = "Red: \(dont.redValue!), Green: \(dont.greenValue!), Blue: \(dont.blueValue!) !!!"
                animateConstraint(constraint: leading, ending: 34.0)
                animateConstraint(constraint: trailing, ending: 34.0)
            }
        }
    }
    @IBAction func dismissView(_ sender: Any) {
        animateConstraint(constraint: leading, ending: 434.0)
        animateConstraint(constraint: trailing, ending: 366.0)
    }
    
    func animateConstraint(constraint: NSLayoutConstraint, ending: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10.0, options: .curveEaseInOut, animations: {
            constraint.constant = ending
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

