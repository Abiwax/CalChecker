//
//  CalorieData.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2017-03-22.
//  Copyright © 2017 Abisola Adeniran. All rights reserved.
//

import UIKit
struct FoodDataKeys {
    static let food_id = "food_id"
    static let food_name = "food_name"
    static let food_url = "food_url"
    static let food_description = "food_description"
    static let food_type = "food_type"
}


class FoodData: NSObject, NSCoding {
    var food_id: String
    var food_name: String
    var food_url: String
    var food_description: String
    var food_type: String
    
    
    
    init(food_id: String, food_name: String, food_url: String, food_description: String, food_type: String) {
        self.food_id = food_id
        self.food_name = food_name
        self.food_url = food_url
        self.food_description = food_description
        self.food_type = food_type
    }
    
    
    //required for NSCoding
    required init?(coder decoder: NSCoder) {
        food_id = decoder.decodeObject(forKey: FoodDataKeys.food_id) as! String
        food_name = decoder.decodeObject(forKey: FoodDataKeys.food_name) as! String
        food_url = decoder.decodeObject(forKey: FoodDataKeys.food_url) as! String
        food_description = decoder.decodeObject(forKey: FoodDataKeys.food_description) as! String
        food_type = decoder.decodeObject(forKey: FoodDataKeys.food_type) as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(food_id, forKey: FoodDataKeys.food_id)
        coder.encode(food_name, forKey: FoodDataKeys.food_name)
        coder.encode(food_url, forKey: FoodDataKeys.food_url)
        coder.encode(food_description, forKey: FoodDataKeys.food_description)
        coder.encode(food_type, forKey: FoodDataKeys.food_type)
    }
}


