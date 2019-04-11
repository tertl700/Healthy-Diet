//
//  Person+CoreDataClass.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/11/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    convenience init?(name: String, age: Int16, height: Float, weight: Float, activity: Int16) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            name != "",
            age < 0,
            height < 0,
            weight < 0,
            activity < 0 else {
            return nil
        }
        
        self.init(entity: Person.entity(), insertInto: managedContext)
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.activity = activity
    }
}
