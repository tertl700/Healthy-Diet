//
//  FoodLog+CoreDataClass.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/25/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//
//

import UIKit
import CoreData

@objc(FoodLog)
public class FoodLog: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(calorie: Double, breakfast: [Food], lunch: [Food], dinner: [Food]) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: FoodLog.entity(), insertInto: managedContext)
        self.totalCalorie = calorie
        self.date = Date(timeIntervalSinceNow: 0)
        self.breakfast?.addingObjects(from: breakfast)
        self.lunch?.addingObjects(from: lunch)
        self.dinner?.addingObjects(from: dinner)
    }
}
