//
//  Person+CoreDataProperties.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/23/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var activity: Double
    @NSManaged public var age: Int16
    @NSManaged public var height: Double
    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var gender: Int16
    @NSManaged public var calorieFloor: Double
    @NSManaged public var calorieCeiling: Double
    @NSManaged public var weightDesire: Double

}
