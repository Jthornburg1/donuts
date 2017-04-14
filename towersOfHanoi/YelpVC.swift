//
//  YelpVC.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/12/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit
import YelpAPI
import CoreLocation

class YelpVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, SearcherDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let yelp_client_id = "n3JUxUNes-twIo_OAlra1g"
    let yelp_secret = "ZBO46Xe39JFTwKfGVR8IVtfgj7v07wFdhvfzkbVsh31fC5kv9FtiABTocAUw45nT"
    var yelp_client: YLPClient?
    let locationManager = CLLocationManager()
    var searchterm: String?
    var ylpCoord: YLPCoordinate?
    var items = [YLPBusiness]()
    var label: UILabel?
    var searchTitle: String?
    var isUpdatingLocation = false
    var hasUpdatedLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.stopUpdatingLocation()
        
        tableView.isHidden = true
        
        ylpCoord = YLPCoordinate(latitude: 29.9567404, longitude: -90.0663997)
        
        
        
        let nib = UINib(nibName: "YelpCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "YelpCell")
        
        let time = DispatchTime.now() + 10
        DispatchQueue.main.asyncAfter(deadline: time) {
            
            self.locationManager.startUpdatingLocation()
            self.isUpdatingLocation = true
            self.askForPermission()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: -60, left: 0, bottom: 0, right: 0)
        locationManager.delegate = self
        YLPClient.authorize(withAppId: yelp_client_id, secret: yelp_secret) { (client, error) in
            if let clnt = client {
                self.yelp_client = clnt
                self.yelpSearch()
            }
            if error != nil {
                print("There has been as error getting the Yelp client: \(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items.removeAll()
        tableView.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func slideInSearchNarrower(_ sender: Any) {
        performSegue(withIdentifier: "SearchTermSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        label?.removeFromSuperview()
        label = nil
        
        if segue.identifier == "SearchTermSegue" {
            let vc = segue.destination as! YelpTermListVC
            vc.delegate = self
        }
    }
    
    func showDeniedAlert() {
        let alert = UIAlertController(title: "Permission denied", message: "This Feature requires use of your location, else you're stuck seeing only stuff in the French Quarter of New Orleans", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func presentEmptySearch() {
        label = UILabel(frame: CGRect(x: 50, y: 200, width: self.view.frame.width - 100, height: 80))
        label?.textAlignment = .center
        label?.font = UIFont(name: "Optima", size: 20)
        label?.textColor = UIColor.darkGray
        if let trm = self.searchterm {
            label?.text = "No results here for \n\(trm)"
        }
        label?.text = "No results here for \n\(String(describing: self.searchTitle!))"
        label?.numberOfLines = 2
        self.view.addSubview(label!)
    }
    
    // Yelp Functions
    func yelpSearch() {
        self.items.removeAll()
        var term: String
        if let coord = ylpCoord {
            if let trm = searchterm {
                term = trm
            } else {
                term = "food"
            }
            if let client = yelp_client {
                client.search(with: coord, term: term, limit: 40, offset: 5, sort: .highestRated, completionHandler: { (search, error) in
                    if let srch = search {
                        if srch.total == 0 {
                            self.presentEmptySearch()
                            self.tableView.isHidden = true
                            return
                        }
                        for business in srch.businesses {
                            self.items.append(business)
                        }
                        DispatchQueue.main.async(execute: {
                            if self.items.count > 0 {
                                self.tableView.isHidden = false
                                self.tableView.reloadData()
                            } else {
                                self.presentEmptySearch()
                            }
                        })
                     }
                     if let err = error {
                        print("Yelp search error: \(err.localizedDescription)")
                     }
                })
            }
        }
    }
    
    // LocationManager callbacks
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lst = locations.last {
            if ylpCoord != YLPCoordinate(latitude: lst.coordinate.latitude, longitude: lst.coordinate.longitude) {
                ylpCoord = YLPCoordinate(latitude: lst.coordinate.latitude, longitude: lst.coordinate.longitude)
            }
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error with locationManager: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            print("Authorized")
            let time = DispatchTime.now() + 10
            DispatchQueue.main.asyncAfter(deadline: time) {
                if !self.isUpdatingLocation {
                    self.locationManager.startUpdatingLocation()
                }
            }
        case .denied:
            showDeniedAlert()
            locationManager.stopUpdatingLocation()
            isUpdatingLocation = false
        default:
            break
        }
    }
    
    func askForPermission() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            print("authorized")
            locationManager.startUpdatingLocation()
        case .denied:
            showDeniedAlert()
        default:
            return
        }
    }
    
    // UItableView functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YelpCell") as? YelpCell
        cell?.configure(yelpItem: items[indexPath.row])
        if let url = items[indexPath.row].imageURL {
            cell?.placeImageView.downloadFrom(url: url)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // SearcherDelegate
    func searchBy(searchTerm: String, termTitle: String) {
        self.searchterm = searchTerm
        self.searchTitle = termTitle
        yelpSearch()
    }
}
