//
//  FoodCalcViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/16/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class FoodCalcViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var breakfastFoods: [Food] = [Food(cal: 12.1, name: "food 1")]
    var lunchFoods: [Food] = [Food(cal: 12.1, name: "food 2")]
    var dinnerFoods: [Food] = [Food(cal: 12.1, name: "food 3")]
    var selectType: MealType?
    
    @IBOutlet weak var mealListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectType = MealType.breakfast
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Breakfast"
        case 1:
            return "Lunch"
        case 2:
            return "Dinner"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return breakfastFoods.count
        case 1:
            return lunchFoods.count
        case 2:
            return dinnerFoods.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        let mealFoods: [Food]?
        switch indexPath.section {
        case 0:
            mealFoods = breakfastFoods
        case 1:
            mealFoods = lunchFoods
        case 2:
            mealFoods = dinnerFoods
        default:
            mealFoods = nil
        }
            
        if let meal = mealFoods?[indexPath.row] {
            cell.textLabel?.text = meal.name
            cell.detailTextLabel?.text = String(meal.cal)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FoodFinderViewController {
            destination.type = selectType
        }
    }
    
    @IBAction func unwindToFoodCalc(for segue: UIStoryboardSegue) {
        if let source = segue.source as? FoodFinderViewController {
            if let selectType = selectType {
                if let food = source.selectedFood {
                    print(food)
                    switch selectType {
                    case MealType.breakfast:
                        breakfastFoods.append(food)
                    case MealType.lunch:
                        lunchFoods.append(food)
                    case MealType.dinner:
                        dinnerFoods.append(food)
                    }
                }
            }
        }
        
        mealListTableView.reloadData()
    }
    
}
