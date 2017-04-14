//
//  YelpTermListVC.swift
//  towersOfHanoi
//
//  Created by Jon Thornburg on 4/13/17.
//  Copyright © 2017 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

protocol SearcherDelegate {
    func searchBy(searchTerm: String, termTitle: String)
}

class YelpTermListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var delegate: SearcherDelegate?
    var terms: [YelpCategory]?
    var parents = [String : [YelpCategory]]()
    var unwieldyButUsable = [[String : [YelpCategory]]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: -65, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        getArray()
    }
    
    func getArray() {
        HTTPCaller.shared.getCategories { (cats) in
            self.terms = cats
            self.prepareForReload()
        }
    }
    
    func prepareForReload() {
        if let trms = terms {
            for ypCat in trms {
                for prnt in ypCat.parents! {
                    if self.parents[prnt] == nil {
                        self.parents[prnt] = [ypCat]
                        print("Got 1!!!")
                    } else {
                        self.parents[prnt]?.append(ypCat)
                    }
                }
            }
            self.unwieldyButUsable = arrFrom(dict: self.parents)
            tableView.reloadData()
        }
    }
    
    func arrFrom(dict: [String : [YelpCategory]]) -> [[String : [YelpCategory]]] {
        
        var collection = [[String : [YelpCategory]]]()
        for (k,v) in dict {
            let nV = v.sorted(by: { $0.title! < $1.title! })
            let individual = [k : nV]
            collection.append(individual)
        }
        collection.sort(by: { $0.keys.first! < $1.keys.first! })
        return collection
    }
    
    // TableView Funcs
    func numberOfSections(in tableView: UITableView) -> Int {
        return unwieldyButUsable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (unwieldyButUsable[section].values.first?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = (unwieldyButUsable[indexPath.section].values.first?[indexPath.row].title)!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (unwieldyButUsable[section].keys.first)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchString = (unwieldyButUsable[indexPath.section].values.first?[indexPath.row].alias)!
        let title = (unwieldyButUsable[indexPath.section].values.first?[indexPath.row].title)!
        delegate?.searchBy(searchTerm: searchString, termTitle: title)
        navigationController?.popViewController(animated: true)
    }
    
}
