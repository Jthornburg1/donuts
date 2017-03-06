//
//  Country.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/6/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation

class Country {
    
    var name: String?
    var code: String?
    
    init(dict: [String : AnyObject]) {
        fromDict(dict: dict)
    }
    
    func getName() -> String? {
        return name
    }
    func getCode() -> String? {
        return code
    }
    
    func fromDict(dict: [String : AnyObject]) {
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let code = dict["alpha2Code"] as? String {
            self.code = code
        }
    }
}
