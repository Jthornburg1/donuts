//
//  HTTPCaller.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/13/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation

struct HTTPCaller {
    
    public static let shared = HTTPCaller()
    
    private init(){}
    
    func getCategories(completion: @escaping ([YelpCategory]) -> Void) {
        let url = URL(string: "https://www.yelp.com/developers/documentation/v2/all_category_list/categories.json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        var categories = [YelpCategory]()
        let task = session.dataTask(with: request) { (data, response, error) in
            if let dta = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: dta, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [[String : AnyObject]] {
                        
                        for dict in json {
                            let newCategory = YelpCategory(dictionary: dict)
                            if newCategory.country_blacklist == false && newCategory.country_whitelist == false {
                                categories.append(newCategory)
                            }
                        }
                        DispatchQueue.main.async(execute: { 
                            completion(categories)
                        })
                    }
                    
                } catch let error as NSError {
                    print("There has been an error getting Yelp Categories: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
