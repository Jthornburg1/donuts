//
//  YelpCategory.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/13/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation

class YelpCategory {
    
    var alias: String?
    var title: String?
    var parents: [String]?
    var country_whitelist = false
    var country_blacklist = false
    
    init(dictionary: [String : AnyObject]) {
        fromDictionary(dictionary: dictionary)
    }
    
    func fromDictionary(dictionary: [String : AnyObject]) {
        if let alias = dictionary["alias"] as? String {
            self.alias = alias
        }
        if let title = dictionary["title"] as? String {
            self.title = title
        }
        if let parents = dictionary["parents"] as? [String] {
            self.parents = parents
        }
        if (dictionary["country_whitelist"] as? [String]) != nil {
            self.country_whitelist = true
        }
        if (dictionary["country_blacklist"] as? String) != nil {
            self.country_blacklist = true
        }
    }
}
