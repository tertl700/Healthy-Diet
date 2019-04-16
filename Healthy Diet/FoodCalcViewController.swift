//
//  FoodCalcViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/16/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class FoodCalcViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var foods: [Food] = []
    var search = ""
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var foodTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func performSearch(_ sender: Any) {
        search = searchTextField?.text ?? ""
        Food.foods(search: search, completion: {(foods: [Food]) -> Void in
            self.foods = foods
        })
        foodTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        let n = foods[indexPath.row].name
        let c = String(foods[indexPath.row].cal)
        
        cell.textLabel?.text = n
        cell.detailTextLabel?.text = c
        
        return cell
    }

}
