//
//  YelpVC.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/12/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class YelpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendYelpPostRequest { (str) in
            
        }
    }
    
    func sendYelpPostRequest(completion: (String) -> Void) {
        let urlString = "https://api.yelp.com/oauth2/token"
        let url = NSURL(string: urlString)
        var request = URLRequest(url: url! as URL)
        let body = ["client_id" : "n3JUxUNes-twIo_OAlra1g", "grant_type" : "client_credentials", "client_secret" : "ZBO46Xe39JFTwKfGVR8IVtfgj7v07wFdhvfzkbVsh31fC5kv9FtiABTocAUw45nT"]
        let jsonData = try? JSONSerialization.data(withJSONObject: <#T##Any#>, options: <#T##JSONSerialization.WritingOptions#>)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let dta = data {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: dta, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! [String : AnyObject]
                    print("Hey Fucker: \(json)")
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                
            }
        }
        task.resume()
    }
}
