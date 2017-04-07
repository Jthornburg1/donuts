//
//  StairsViewController.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/7/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class StairsViewController: UIViewController {
    
    @IBOutlet weak var SC1: StairWellCreator!
    @IBOutlet weak var SC2: StairWellCreator!
    @IBOutlet weak var SC3: StairWellCreator!
    @IBOutlet weak var SC4: StairWellCreator!
    
    var arr = [StairWellCreator]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arr = [SC1, SC2, SC3, SC4]
    }
    
    @IBAction func makeStairs(_ sender: Any) {
        for creator in arr {
            creator.progress(x: 0, y: 0, first: true, numberDone: -1, floorCount: 0, completion: {
                
            })
        }
    }
    
}
