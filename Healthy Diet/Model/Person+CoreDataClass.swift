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
    convenience init?(name: String, age: Int16, gender: Int16, height: Double, weight: Double, activity: Double, weightDesire: Int16) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext, name != "" else {
            return nil
        }
        
/*

         Activity levels are in an email from Haley.
         
         if sedentay
         
         
*/
        
        self.init(entity: Person.entity(), insertInto: managedContext)
        self.name = name
        self.age = age
        self.gender = gender
        self.height = height
        self.weight = weight
        self.activity = activity
        self.weightDesire = weightDesire
        let calTarget = determineCalorie(weight, height, age, activity, gender, weightDesire)
        self.calorieFloor = calTarget.0
        self.calorieCeiling = calTarget.1
    }
    
    func determineCalorie(_ weight: Double, _ height: Double, _ age: Int16, _ activity: Double, _ gender: Int16, _ weightDesire: Int16) -> (Double, Double) {
        let rmr: Double
        let wrmr = 9.99 * weight
        let hrmr = 6.25 * height
        let armr = 4.92 * Double(age)
        
        switch gender {
        case 0:
            rmr = wrmr + hrmr + armr + 5
        case 1:
            rmr = wrmr + hrmr + armr - 161
        default:
            return (0.0, 0.0)
        }
        
        let cal1 = rmr * activity
        let cal2: Double
        switch weightDesire {
        case 0:
            cal2 = cal1 - 500
            return (cal2, cal1)
        case 1:
            cal2 = cal1 + 500
            return (cal1, cal2)
        default:
            cal2 = cal1
            return (cal1, cal2)
        }
    }
    
    func calorieMatch(_ calorie: Double) -> Bool {
        if calorie >= self.calorieFloor && calorie <= self.calorieCeiling {
            return true
        }
        return false
    }
}
