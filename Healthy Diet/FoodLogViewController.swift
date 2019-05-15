//
//  FoodLogViewController.swift
//  Healthy Diet
//
//  Created by Tommy Ertl on 5/2/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit
import CoreData

class FoodLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var calorieProgressLabel: UILabel!
    @IBOutlet weak var mealListTableView: UITableView!
    
    
    
    var breakfastFoods: [Food] = []
    var lunchFoods: [Food] = []
    var dinnerFoods: [Food] = []
    var foodLogItem: FoodLog?
    var selectType: MealType?
    var totalCalorie: Double = 0.0
    var dateSelected: Date?
    
    private var datePicker: UIDatePicker?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(FoodLogViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FoodLogViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePicker
        
        getCurrentDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //retrieveFoodData()
        retrieveFoodLogData()
        
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    

    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    func getCurrentDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        dateTextField.text = dateFormatter.string(from: Date.init())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func retrieveFoodLogData(){
        //        guard let selectedDate = dateSelected else {
        //            return
        //        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let moc = appDelegate.persistentContainer.viewContext
        //var moc:NSManagedObjectContext!
        
        
        let fetchRequest:NSFetchRequest<FoodLog> = FoodLog.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rawDate", ascending: false)]
        //
        //        let calendar = NSCalendar.current
        //        let startDate = calendar.startOfDay(for: selectedDate)
        //        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        //
        //        fetchRequest.predicate = NSPredicate.init(format: "(rawDate >= %@) AND (rawDate < %@)", argumentArray: [startDate, endDate])
        
        do{
            try print(moc.fetch(fetchRequest).count)
            try foodLogItem = moc.fetch(fetchRequest).first
        } catch{
            print("Food Data exported unsuccessfully")
        }
        
        if let foodLogItem = foodLogItem {
            breakfastFoods = foodLogItem.breakfast?.allObjects as! [Food]
            lunchFoods = foodLogItem.lunch?.allObjects as! [Food]
            dinnerFoods = foodLogItem.dinner?.allObjects as! [Food]
        }
        
        mealListTableView.reloadData()
        //self.tableView.reloadData()
    }
    
    func deleteFoodData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let moc = appDelegate.persistentContainer.viewContext
        
        let fetchReqeust = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReqeust)
        
        do {
            try moc.execute(deleteRequest)
            try moc.save()
        } catch let error as NSError {
            print(error.description)
        }
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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

}
