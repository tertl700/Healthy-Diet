//
//  Food+CoreDataClass.swift
//  Healthy Diet
//
//  Created by Ryan Lokugamage on 4/25/19.
//  Copyright © 2019 Tommy Ertl. All rights reserved.
//
//

import UIKit
import CoreData

enum MealType: Int {
    case breakfast
    case lunch
    case dinner
}

enum SerializationError: Error {
    case noName(String)
    case noCal(String)
    case noPor(String)
}

@objc(Food)
public class Food: NSManagedObject {
    convenience init?(json: [String: Any]) throws {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        guard let name = json["name"] as? String else {
            throw SerializationError.noName(json.values.description)
        }
        guard let cal = json["cal"] as? Double else {
            throw SerializationError.noCal(json.values.description)
        }
        guard let por = json["portion"] as? String else {
            throw SerializationError.noPor(json.values.description)
        }
        
        self.init(entity: Food.entity(), insertInto: managedContext)
        self.foodName = name
        self.calorie = cal
        self.portion = por
    }
    
    static func foods(search: String, completion: @escaping ([Food]) -> Void) {
        let endpoint = "http://ec2-34-207-164-147.compute-1.amazonaws.com:8081/foods/\(search)"
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var foods = [Food]()
            
            guard let data = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let json = try JSONSerialization.jsonObject(with:
                    data, options: [])
                
                guard let jsonArray = json as? [[String: Any]] else {
                    return
                }
                for case let result in jsonArray {
                    if let food = try Food(json: result) {
                        foods.append(food)
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
            
            completion(foods)
        }
        
        task.resume()
    }
}
