//
//  FoodCalcViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/16/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class FoodCalcViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var breakfastFoods: [Food] = []
    var lunchFoods: [Food] = []
    var dinnerFoods: [Food] = []
    var selectType: MealType?
    
    @IBOutlet weak var mealListTableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectType = MealType.breakfast
    }
    
    @IBAction func changeSelectType(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Meal", message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        alert.addAction(UIAlertAction(title: "Breakfast", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
                self.selectType = MealType.breakfast
                self.selectButton.titleLabel?.text = "Breakfast"
        }))
        alert.addAction(UIAlertAction(title: "Lunch", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.selectType = MealType.lunch
            self.selectButton.titleLabel?.text = "Lunch"
        }))
        alert.addAction(UIAlertAction(title: "Dinner", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.selectType = MealType.dinner
            self.selectButton.titleLabel?.text = "Dinner"
        }))
        
        self.present(alert, animated: true, completion: nil)
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
            let name = meal.foodName ?? ""
            cell.textLabel?.text = "\(name) \(meal.calorie)"
            cell.detailTextLabel?.text = meal.portion
        }
        
        return cell
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
