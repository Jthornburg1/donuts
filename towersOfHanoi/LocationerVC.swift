//
//  LocationerVC.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 3/6/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

enum SearchType: String {
    case None = "Start Search"
    case Country = "Pica Country"
    case State = "Pica State"
    case City = "Pica City"
}

class LocationerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var pickerPopulator: [String]?
    var countries: [Country]?
    var states: [State]?
    var searchT = SearchType.None
    var country: Country?
    var state: State?
    var City: City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries = [Country]()
        states = [State]()
        pickerPopulator = [String]()
        pickerView.backgroundColor = UIColor.black
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.layer.cornerRadius = 20
        pickerView.clipsToBounds = true
        pickerView.alpha = 0.0
        button.setTitle(searchT.rawValue, for: .normal)
        getCountries { (arr) in
            print("got countries")
        }
        getStates()
    }
    @IBAction func pickerShowerTapped(_ sender: Any) {
        pickerView.reloadAllComponents()
        if searchT == SearchType.None {
            UIView.animate(withDuration: 0.5, animations: {
                self.pickerView.alpha = 1.0
            }) { (tru) in
                if tru {
                    self.pickerView.selectRow(0, inComponent: 0, animated: true)
                    self.searchT = SearchType.Country
                    self.button.setTitle(SearchType.Country.rawValue, for: .normal)
                }
            }

        }
    }
    
    // picker methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let cntr = self.countries {
            return cntr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attr = [NSForegroundColorAttributeName:UIColor.white]
        if let cntrs = countries {
            let str = NSAttributedString(string: cntrs[row].name!, attributes: attr)
            return str
        }
        let attrs = NSAttributedString()
        return attrs
    }
    
    func getCountries(completion: @escaping ([String]) -> Void) {
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let dta = data {
                
                print(dta)
                
                do {
                    let parsedJson = try JSONSerialization.jsonObject(with: dta, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [[String : AnyObject]]
                    for country in parsedJson! {
                        let country = Country(dict: country)
                        print("name: \(country.name!)")
                        self.countries?.append(country)
                    }
                } catch let error as NSError {
                    print("JSON error has occurred: \(error.localizedDescription)")
                }
                
            }
        }
        task.resume()
    }
    
    func getStates() /*-> [State]*/ {
        let pathString = Bundle.main.path(forResource: "states", ofType: "plist")
        let data: NSData? = NSData(contentsOfFile: pathString!)
        let datasourceDictionary = try! PropertyListSerialization.propertyList(from: data as! Data, options: [], format: nil) as! [[String : AnyObject]]
        
        for item in datasourceDictionary {
            
            let state = State(name: item["name"] as! String?, country: item["country"] as! String?)
            states?.append(state)
        }
    }
    
    func getStatesFor(country: Country) -> [State] {
        var sts = [State]()
        for state in self.states! {
            if state.country! == country.name! {
                sts.append(state)
            }
        }
        return sts
    }
}
