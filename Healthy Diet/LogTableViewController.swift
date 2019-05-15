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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //selectType = MealType.breakfast

        //moc = appDelegate?.persistentContainer.viewContext
        //deleteFoodData()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "foodLogDateSegue" {
//            if let destination = segue.destination as? LogTableViewController {
//                destination.dateSelected = datePicker?.date
//            }
//        }
//    }
    
    
//    func retrieveFoodData(){
//        let fetchRequest:NSFetchRequest<Food> = Food.fetchRequest()
//
//        do{
//            try breakfastFoods = moc.fetch(fetchRequest)
//            try lunchFoods = moc.fetch(fetchRequest)
//            try dinnerFoods = moc.fetch(fetchRequest)
//        } catch{
//            print("Food exported unsuccessfully")
//        }
//
//        self.tableView.reloadData()
//
////        do{
////            let result = try managedContext.fetch(fetchRequest)
////
////            for data in result as! [NSManagedObject]{
////                return data
////            }
////        }catch let error as NSError{
////                print(error.description)
////            }
//
//    }
    
    

    // MARK: - Table view data source

    

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
