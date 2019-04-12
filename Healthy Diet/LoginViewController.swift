//
//  ViewController.swift
//  Healthy Diet
//
//  Created by Tommy Ertl on 3/21/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        spinner.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if self.fetchUser() {
                self.performSegue(withIdentifier: "mainSegue", sender: self)
            } else {
                self.performSegue(withIdentifier: "createAccountSegue", sender: self)
            }
        }
    }
    
    func fetchUser() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            person = try managedContext.fetch(fetchRequest).first
            managedContext.delete(person!)
            return false
        } catch {
            alertNotifyUser(message: "Fetch for person could not be performed.")
            return false
        }
        if person == nil { return false }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MainPageViewController {
            if segue.identifier == "mainSegue" {
                destination.person = person
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

}

