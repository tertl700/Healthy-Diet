//
//  LogTableViewController.swift
//  Healthy Diet
//
//  Created by Tommy Ertl on 5/13/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit
import CoreData

class LogTableViewController: UITableViewController{

    @IBOutlet weak var mealListTableView: UITableView!
    var breakfastFoods: [Food] = []
    var lunchFoods: [Food] = []
    var dinnerFoods: [Food] = []
    var foodLogItems: [FoodLog] = []
    var selectType: MealType?
    var totalCalorie: Double = 0.0
    
    
    
    var moc:NSManagedObjectContext!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //selectType = MealType.breakfast

        moc = appDelegate?.persistentContainer.viewContext
        deleteFoodData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveFoodData()
        retrieveFoodLogData()
        
        
    }
    
    func retrieveFoodData(){
        let fetchRequest:NSFetchRequest<Food> = Food.fetchRequest()
        
        //let sortDescriptor = NSSortDescriptor(key: "rawDate", ascending: false)
        
        do{
            try breakfastFoods = moc.fetch(fetchRequest)
            try lunchFoods = moc.fetch(fetchRequest)
            try dinnerFoods = moc.fetch(fetchRequest)
        } catch{
            print("Food exported unsuccessfully")
        }
        
        self.tableView.reloadData()
        
//        do{
//            let result = try managedContext.fetch(fetchRequest)
//
//            for data in result as! [NSManagedObject]{
//                return data
//            }
//        }catch let error as NSError{
//                print(error.description)
//            }
        
    }
    
    func retrieveFoodLogData(){
        let fetchRequest:NSFetchRequest<FoodLog> = FoodLog.fetchRequest()

        do{
            try foodLogItems = moc.fetch(fetchRequest)
        } catch{
            print("Food Data exported unsuccessfully")
        }
        
        self.tableView.reloadData()
    }
    
    func deleteFoodData() {
        let fetchReqeust = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReqeust)
        
        do {
            try moc!.execute(deleteRequest)
            try moc!.save()
        } catch let error as NSError {
            print(error.description)
        }
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath)
        
        let foodLog = FoodLog(calorie: totalCalorie , breakfast: breakfastFoods, lunch: lunchFoods, dinner: dinnerFoods)
//        let foodItem = foodItems[indexPath.row]
//        let foodLogItem = foodLogItems[indexPath.row]
        
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
            cell.textLabel?.text = "\(name) \(meal.portion ?? "")"
        }
        
        //let foodPortion = foodItem.portion
        //cell.detailTextLabel?.text = foodPortion
        
        //guard let foodDate = foodItem.breakfastLog?.rawDate as Date? else {return cell}
        guard let foodDate = foodLog?.rawDate as Date? else {return cell}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy, hh:mm"
        
        cell.detailTextLabel?.text = dateFormatter.string(from: foodDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
