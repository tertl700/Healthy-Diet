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
    var personItem: Person?
    var selectType: MealType?
    var totalCalorie: Double = 0.0
    var dailyCalories: Double = 0.0
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
        breakfastFoods.removeAll()
        lunchFoods.removeAll()
        dinnerFoods.removeAll()
        retrieveFoodLogData()
        personItem = retrievePersonData()
        var calorieDenominator: Double
        
        if let person = personItem {
            calorieDenominator = person.calorieFloor
        } else {
            calorieDenominator = 2000
        }
        if let foodLog = foodLogItem {
            totalCalorie = foodLog.totalCalorie
        } else {
            totalCalorie = calculateCalorie()
        }
        
        let calorieNeeds = (totalCalorie)/(calorieDenominator)
        
        //let calorieProgress = String(format: "%f", calorieNeeds)
        calorieProgressLabel.text = String(format:"You are %.2f%% towards your daily calorie goal", calorieNeeds*100)
        dateSelected = datePicker?.date
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
        //self.viewDidLoad()
        self.viewWillAppear(true)
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
        dateSelected = datePicker?.date
                let calendar = NSCalendar.current
                let startDate = calendar.startOfDay(for: dateSelected!)
                let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        
        fetchRequest.predicate = NSPredicate.init(format: "(rawDate > %@) AND (rawDate < %@)", argumentArray: [startDate, endDate!])
        
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
    
     func retrievePersonData() -> Person?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let moc = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        var person :Person?
        do{
            try person = moc.fetch(fetchRequest).last
        } catch{
            print("Food Data exported unsuccessfully")
        }
        
        return person
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = .init(displayP3Red: 0, green: 0.59, blue: 1.0, alpha: 1.0)
        headerView.textLabel?.textColor = .white
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
        
        totalCalorie = calculateCalorie()

//        guard let foodDate = foodLog?.rawDate as Date? else {return cell}
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        if let meal = mealFoods?[indexPath.row] {
            let name = meal.foodName ?? ""
            cell.textLabel?.text = "\(name)"
            //cell.textLabel?.text = "\(name) \(meal.portion ?? "")"
            cell.detailTextLabel?.text = "\(meal.portion ?? "")"
        }
        
        
        
        //cell.detailTextLabel?.text = dateFormatter.string(from: foodDate)
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
    
    func calculateCalorie() -> Double {
        var calorie = 0.0
        calorie += breakfastFoods.reduce(0.0) { cal,food in cal + food.calorie }
        calorie += lunchFoods.reduce(0.0) { cal,food in cal + food.calorie }
        calorie += dinnerFoods.reduce(0.0) { cal,food in cal + food.calorie }
        return calorie
    }


}
