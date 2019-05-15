//
//  CreateAccountViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/11/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var inchesHeightTextField: UITextField!
    @IBOutlet weak var desiredWeightTextField: UITextField!
    @IBOutlet weak var feetHeightTextField: UITextField!
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    var genderList = ["Male", "Female"]
    var activityList = ["Sedentary", "Slightly Active", "Moderately Active", "Very Active", "Extremely Active"]
    var footList = ["4", "5", "6", "7"]
    var inchList = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    
    var activeField: UITextField!
    var gender: Int16 = 0
    var activityLevel: Double = 0
    var person: Person?
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(activeField == genderTextField){
            return genderList.count
        }else if(activeField == inchesHeightTextField){
            return inchList.count
        }else if(activeField == feetHeightTextField){
            return footList.count
        }else{
            return activityList.count
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(activeField == genderTextField){
            self.genderTextField.text = self.genderList[row]
            picker.isHidden = true
            // depending on row chosen select the gender int16 value into gender variable
            if(row == 0){
                gender = 0
            }else {
                gender = 1
            }
            
        } else if(activeField == activityTextField){
            self.activityTextField.text = self.activityList[row]
            picker.isHidden = true
            // depending on value of row chosen set value of the activity level
            switch(row){
            case 0:
                activityLevel = 1.2
            case 1:
                activityLevel = 1.375
            case 2:
                activityLevel = 1.55
            case 3:
                activityLevel = 1.725
            case 4:
                activityLevel = 1.9
            default:
                activityLevel = 1
            }
        }else if(activeField == feetHeightTextField){
            self.feetHeightTextField.text = self.footList[row]
            picker.isHidden = true
        }else if(activeField == inchesHeightTextField){
            self.inchesHeightTextField.text = self.inchList[row]
            picker.isHidden = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(activeField == genderTextField){
            return genderList[row]
        }else if(activeField == feetHeightTextField){
            return footList[row]
        }else if(activeField == inchesHeightTextField){
            return inchList[row]
        }else{
            return activityList[row]
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == weightTextField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        if textField == ageTextField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
       
        if textField == desiredWeightTextField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }


        
        return true
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField == activityTextField)
        {
            picker.isHidden = false
            activeField = textField
            picker.reloadInputViews()
            picker.reloadAllComponents()
            
        }else if(textField == genderTextField)
        {
            picker.isHidden = false
            activeField = textField
            picker.reloadInputViews()
            picker.reloadAllComponents()
            
        }else if(textField == feetHeightTextField)
        {
            picker.isHidden = false
            activeField = textField
            picker.reloadInputViews()
            picker.reloadAllComponents()
            
        }else if(textField == inchesHeightTextField)
        {
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
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text else {
            alertNotifyUser(message: "enter a name")
            return
        }
        guard let age = ageTextField.text else {
            alertNotifyUser(message: "enter an age")
            return
        }
        guard let feet = feetHeightTextField.text else {
            alertNotifyUser(message: "enter height in feet")
            return
        }
        guard let inch = inchesHeightTextField.text else {
            alertNotifyUser(message: "enter height in inches")
            return
        }
        guard let weight = weightTextField.text else {
            alertNotifyUser(message: "enter weight in pounds")
            return
        }
        guard let weightDesire = desiredWeightTextField.text else {
            alertNotifyUser(message: "enter desired weight in pounds")
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
        // Conversion  of height into metric in centemeters
        
        let castFeet = Double(feet)! * 30.38
        let castInch = Double(inch)! * 2.54
        
        let height = castInch + castFeet
        let castedWeight = Double(weight)! * 0.4536
        let castedWeightDesire = Double(weightDesire)! * 0.4536
        
        
        if person == nil {
            person = Person(name: trimmedName, age: castedAge!, gender: gender, height: height, weight: castedWeight, activity: activityLevel, weightDesire: castedWeightDesire)
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
