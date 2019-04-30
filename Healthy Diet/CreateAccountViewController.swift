//
//  CreateAccountViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/11/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var genderList = ["Male", "Female"]
    var ageList = ["18-25", "25-30", "30-35", "35-40", "40-45"]
    var activityList = ["Couach Potato", "Average", "Active"]
    var weightList = ["95", "96", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113"]
    
    var activeField: UITextField!
    
    var person: Person?
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(activeField == ageTextField)
        {
            return ageList.count
        }else if(activeField == genderTextField){
            return genderList.count
        }else if(activeField == weightTextField){
            return weightList.count
        }
        else{
            return ageList.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(activeField == genderTextField){
            self.genderTextField.text = self.genderList[row]
            picker.isHidden = true
        } else if(activeField == weightTextField){
            self.weightTextField.text = self.weightList[row]
            picker.isHidden = true
        } else {
            self.ageTextField.text = self.ageList[row]
            picker.isHidden = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(activeField == ageTextField){
            return ageList[row]
        }else if(activeField == genderTextField){
            return genderList[row]
        }else if(activeField == weightTextField){
            return weightList[row]
        }else {
            return ageList[row]
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField != nameTextField){
            picker.isHidden = false
            activeField = textField
            picker.reloadInputViews()
            picker.reloadAllComponents()
            
        }else {
            picker.isHidden = true
        }
        return true
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /*
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text else {
            alertNotifyUser(message: "enter a name")
            return
        }
        guard let age = ageTextField.text else {
            alertNotifyUser(message: "enter an age")
            return
        }
        
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        if trimmedName == "" {
            alertNotifyUser(message: "enter a name")
            return
        }
        
        let castedAge = Int16(age)
        if castedAge == nil {
            alertNotifyUser(message: "enter an age")
            return
        }
        
        if person == nil {
            person = Person(name: trimmedName, age: castedAge!, height: 0.0, weight: 0.0, activity: 0)
        }
        
        if let person = person {
            do {
                let managedContext = person.managedObjectContext
                try managedContext?.save()
                self.performSegue(withIdentifier: "accountToMainSegue", sender: self)
            } catch {
                alertNotifyUser(message: "The person could not be saved.")
            }
        }
    }
    */
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            (alertAction) -> Void in
            print("OK selected")
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainPageViewController {
            if segue.identifier == "accountToMainSegue" {
                destination.person = person
            }
        }
    }
}
