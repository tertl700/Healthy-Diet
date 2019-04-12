//
//  CreateAccountViewController.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/11/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    var person: Person?
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
