//
//  FoodLogViewController.swift
//  Healthy Diet
//
//  Created by Tommy Ertl on 5/2/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class FoodLogViewController: UIViewController {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var calorieProgressLabel: UILabel!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodLogDateSegue" {
            if let destination = segue.destination as? LogTableViewController {
                destination.dateSelected = datePicker?.date
            }
        }
    }

}
