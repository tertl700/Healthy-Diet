//
//  FoodLog+CoreDataProperties.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/25/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//
//

import Foundation
import CoreData


extension FoodLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodLog> {
        return NSFetchRequest<FoodLog>(entityName: "FoodLog")
    }

    @NSManaged public var rawDate: NSDate?
    @NSManaged public var totalCalorie: Double
    @NSManaged public var breakfast: NSSet?
    @NSManaged public var dinner: NSSet?
    @NSManaged public var lunch: NSSet?

}

// MARK: Generated accessors for breakfast
extension FoodLog {

    @objc(addBreakfastObject:)
    @NSManaged public func addToBreakfast(_ value: Food)

    @objc(removeBreakfastObject:)
    @NSManaged public func removeFromBreakfast(_ value: Food)

    @objc(addBreakfast:)
    @NSManaged public func addToBreakfast(_ values: NSSet)

    @objc(removeBreakfast:)
    @NSManaged public func removeFromBreakfast(_ values: NSSet)

}

// MARK: Generated accessors for dinner
extension FoodLog {

    @objc(addDinnerObject:)
    @NSManaged public func addToDinner(_ value: Food)

    @objc(removeDinnerObject:)
    @NSManaged public func removeFromDinner(_ value: Food)

    @objc(addDinner:)
    @NSManaged public func addToDinner(_ values: NSSet)

    @objc(removeDinner:)
    @NSManaged public func removeFromDinner(_ values: NSSet)

}

// MARK: Generated accessors for lunch
extension FoodLog {

    @objc(addLunchObject:)
    @NSManaged public func addToLunch(_ value: Food)

    @objc(removeLunchObject:)
    @NSManaged public func removeFromLunch(_ value: Food)

    @objc(addLunch:)
    @NSManaged public func addToLunch(_ values: NSSet)

    @objc(removeLunch:)
    @NSManaged public func removeFromLunch(_ values: NSSet)

}
