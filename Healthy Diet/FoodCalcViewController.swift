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
    var totalCalorie: Double = 0.0
    
    @IBOutlet weak var mealListTableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectType = MealType.breakfast
    }
    
    @IBAction func exportToFoodLog(_ sender: Any) {
        totalCalorie = calculateCalorie()
        var message = ""
        let foodLog = FoodLog(calorie: totalCalorie, breakfast: breakfastFoods, lunch: lunchFoods, dinner: dinnerFoods)
        
        if let foodLog = foodLog {
            do {
                let managedContext = foodLog.managedObjectContext
                try managedContext?.save()
                message = "food exported successfully"
                managedContext?.reset()
                emptyTableView()
            } catch {
                print(error)
                message = "food exported unsuccessfully"
            }
        }
        
        let alert = UIAlertController(title: "Export Status", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) -> Void in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeSelectType(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Meal", message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        alert.addAction(UIAlertAction(title: "Breakfast", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
                self.selectType = MealType.breakfast
                self.selectButton.setTitle("Breakfast", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "Lunch", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.selectType = MealType.lunch
            self.selectButton.setTitle("Lunch", for: .normal)
        }))
        alert.addAction(UIAlertAction(title: "Dinner", style: UIAlertAction.Style.default, handler: { (alertAction) -> Void in
            self.selectType = MealType.dinner
            self.selectButton.setTitle("Dinner", for: .normal)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
            case 0:
                breakfastFoods.remove(at: indexPath.row)
            case 1:
                lunchFoods.remove(at: indexPath.row)
            case 2:
                dinnerFoods.remove(at: indexPath.row)
            default:
                break
            }
            
            mealListTableView.reloadData()
        }
    }
    
    func emptyTableView() {
        breakfastFoods = []
        lunchFoods = []
        dinnerFoods = []
        
        mealListTableView.reloadData()
    }
    
    @IBAction func unwindToFoodCalc(for segue: UIStoryboardSegue) {
        if let source = segue.source as? FoodFinderViewController {
            if let selectType = selectType {
                if let food = source.selectedFood {
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
    
    func calculateCalorie() -> Double {
        var calorie = 0.0
        calorie += breakfastFoods.reduce(0.0) { cal,food in cal + food.calorie }
        calorie += lunchFoods.reduce(0.0) { cal,food in cal + food.calorie }
        calorie += dinnerFoods.reduce(0.0) { cal,food in cal + food.calorie }
        return calorie
    }
    
}
