//
//  Food+CoreDataProperties.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/25/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var calorie: Double
    @NSManaged public var foodName: String?
    @NSManaged public var portion: String?
    @NSManaged public var breakfastLog: FoodLog?
    @NSManaged public var dinnerLog: FoodLog?
    @NSManaged public var lunchLog: FoodLog?

}
