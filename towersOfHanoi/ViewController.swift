//
//  ViewController.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 2/15/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textF: UITextField!
    var donuts: [DonutView]?
    var orderSize = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        textF.delegate = self
        
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
        }
        return true
    }
    
    func makeTheDonuts() {
        let maker = CircleMaker(numberOrdered: orderSize)
        donuts = maker.fillOrder()
        for donut in donuts! {
            view.addSubview(donut)
        }
    }
    @IBAction func removeDonuts(_ sender: Any) {
        if let donts = donuts {
            for donut in donts {
                donut.removeFromSuperview()
            }
        }
    }
}

