//
//  AnimatingStackViewController.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/16/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class AnimatingStackViewController: UIViewController {
    
    
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet var buttons: [UIButton]! {
        didSet {
            buttons.forEach {
                $0.alpha = 0
            }
        }
    }
    
    var isShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.title = "Show"
        
    }
    
    @IBAction func showHide(_ sender: Any) {
        for button in buttons {
            button.backgroundColor = UIColor.randomColor()
        }
        if !isShowing {
            UIView.animate(withDuration: 0.5, animations: {
                self.buttons.forEach {
                    $0.alpha = 1
                }
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.buttons.forEach {
                    $0.alpha = 0
                }
            })
        }
    }
}
