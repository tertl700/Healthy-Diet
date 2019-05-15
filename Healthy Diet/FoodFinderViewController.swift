//
//  FoodFinderViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/16/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class FoodFinderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var foods = [Food]()
    var selectedFood: Food?
    var search = ""
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = searchButton.frame.size.width / 16
    }
    
    @IBAction func performSearch(_ sender: Any) {
        search = searchTextField?.text ?? ""
        Food.foods(search: search, completion: {(foods: [Food]) -> Void in
            DispatchQueue.main.async {
                self.foods = foods
                self.foodTableView.reloadData()
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = .init(displayP3Red: 0, green: 0.59, blue: 1.0, alpha: 1.0)
        headerView.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        let n = foods[indexPath.row].foodName ?? ""
        let p = foods[indexPath.row].portion ?? ""
        
        cell.textLabel?.text = "\(n)"
        cell.detailTextLabel?.text = "\(p)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFood = foods[indexPath.row]
        self.performSegue(withIdentifier: "unwindToFoodCalc", sender: self)
    }
}
