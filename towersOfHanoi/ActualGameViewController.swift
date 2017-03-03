//
//  ActualGameViewController.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/3/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class ActualGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var firstPin: HanoiPin!
    @IBOutlet weak var secondPin: HanoiPin!
    @IBOutlet weak var thirdPin: HanoiPin!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberSelectorButton: UIButton!
    
    var rings = [DonutView]()
    var pickerIn = false
    let numChoices = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var numSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerConstraint.constant = 500
        picker.delegate = self
        picker.dataSource = self
        
        pickerContainerView.layer.cornerRadius = 10
        pickerContainerView.clipsToBounds = true
    }
    
    @IBAction func chooseNumber(_ sender: Any) {
        pickerContainerView.backgroundColor = UIColor.black
        pickerContainerView.bringSubview(toFront: firstPin)
        if !pickerIn {
            UIView.animate(withDuration: 0.4, animations: {
                self.pickerConstraint.constant = 10
                self.view.layoutIfNeeded()
                self.pickerIn = true
            })
            numberSelectorButton.setTitle("!!", for: .normal)
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.pickerConstraint.constant = 500
                self.view.layoutIfNeeded()
                self.pickerIn = false
            })
            numberSelectorButton.setTitle("#?", for: .normal)
            createDonuts()
        }

    }
    @IBAction func didTapDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func createDonuts() {
        var size: CGFloat = 136
        for _ in 1...numSelected! {
            let newDonut = DonutView(frame: CGRect(x: (self.view.frame.width / 2) - (size / 2), y: 125 - (size / 2), width: size, height: size))
            firstPin.addSubview(newDonut)
            size -= 20
        }
    }
    
    // Pickerview callbacks
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.numChoices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attr = [NSForegroundColorAttributeName:UIColor.magenta]
        let str = NSAttributedString(string: String(describing: numChoices[row]), attributes: attr)
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numSelected = numChoices[row]
    }
    
}
