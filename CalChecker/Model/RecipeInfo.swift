//
//  RecipeInfo.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2017-03-22.
//  Copyright © 2017 Abisola Adeniran. All rights reserved.
//

import UIKit


class RecipeInfo{
    var recipe_id: String
    var recipe_name: String
    var recipe_url: String
    var recipe_description: String
    var number_of_servings: String?
    var preparation_time_min: String?
    var cooking_time_min: String?
    var rating: String
    var recipe_type: String?
    var recipe_image: String?
    var serving_size: String?
    var calories: String?
    var carbohydrate: String?
    var protein: String?
    var fat: String?
    var saturated_fat: String?
    var polyunsaturated_fat: String?
    var monounsaturated_fat: String?
    var trans_fat: String?
    var cholesterol: String?
    var sodium: String?
    var potassium: String?
    var fiber: String?
    var sugar: String?
    var vitamin_a: String?
    var vitamin_c: String?
    var calcium: String?
    var iron: String?
    var ingredient: [IngredientData]?
    var direction: [DirectionData]?
    var category: [CategoryData]?
    
    
    
    
    init(json: [String: Any]) {
        
        if let recipe_id = json["recipe_id"]{
            self.recipe_id = recipe_id as! String
        }
        else{
            self.recipe_id = ""
        }
        
        if let recipe_name = json["recipe_name"]{
            self.recipe_name = recipe_name as! String
        }
        else{
            self.recipe_name = ""
        }
        
        if let recipe_url = json["recipe_url"]{
            self.recipe_url = recipe_url as! String
        }
        else{
            self.recipe_url = ""
        }
        
        
        if let recipe_description = json["recipe_description"] {
            self.recipe_description = recipe_description as! String
        }
        else{
            self.recipe_description = ""
        }
        
        
        if let number_of_servings = json["number_of_servings"] {
            self.number_of_servings = number_of_servings as? String
        }
        else{
            self.number_of_servings = ""
        }
        
        if let rating = json["rating"]{
            self.rating = rating as! String
        }
        else{
            self.rating = ""
        }
        
        if let preparation_time_min = json["preparation_time_min"]{
            self.preparation_time_min = preparation_time_min as? String
        }
        else{
            self.preparation_time_min = ""
        }
        
        if let cooking_time_min = json["cooking_time_min"] {
            self.cooking_time_min = cooking_time_min as? String
        }
            
        else{
            self.cooking_time_min = ""
        }
        
        if let recipe_types = json["recipe_types"] {
            let recipes_types = recipe_types as! [String: Any]
            if let recipes_type = recipes_types["recipe_type"] {
                self.recipe_type = recipes_type as? String
            }
            else{
                self.recipe_type = ""
            }
        }
        
        
        
        if let recipe_images = json["recipe_images"]{
            let recipes_images = recipe_images as! [String: Any]
            
            if let recipe_image = recipes_images["recipe_image"]{
                if ((recipe_image as? String) != nil){
                    self.recipe_image = recipe_image as? String
                }
                else if ((recipe_image as? NSArray) != nil){
                    let recipes = recipe_image as? NSArray
                    let recipe = recipes?[0]
                    print(recipe)
                    self.recipe_image = recipe as! String?
                }
                
            }
            else{
                self.recipe_image = ""
            }
        }
        var serving: [String: Any]!
        if let serving_types = json["serving_sizes"]{
            let serving_type =  serving_types as! [String: Any]
            if let servings = serving_type["serving"]{
                serving = servings as! [String: Any]
                
                if let serving_size = serving["serving_size"] {
                    self.serving_size = serving_size as? String
                }
                
                if let calories = serving["calories"]{
                    self.calories = calories as? String
                }
                
                if let carbohydrate = serving["carbohydrate"]{
                    self.carbohydrate = carbohydrate as? String
                }
                
                if let protein = serving["protein"]{
                    self.protein = protein as? String
                }
                
                if let fat = serving["fat"]{
                    self.fat = fat as? String
                }
                
                if let saturated_fat = serving["saturated_fat"] {
                    self.saturated_fat = saturated_fat as? String
                }
                
                if let polyunsaturated_fat = serving["polyunsaturated_fat"] {
                    self.polyunsaturated_fat = polyunsaturated_fat as? String
                }
                
                if let monounsaturated_fat = serving["monounsaturated_fat"]{
                    self.monounsaturated_fat = monounsaturated_fat as? String
                }
                
                if let trans_fat = serving["trans_fat"]{
                    self.trans_fat = trans_fat as? String
                }
                
                if let cholesterol = serving["cholesterol"]{
                    self.cholesterol = cholesterol as? String
                }
                
                if let sodium = serving["sodium"] {
                    self.sodium = sodium as? String
                }
                
                if let potassium = serving["potassium"]{
                    self.potassium = potassium as? String
                }
                
                if let fiber = serving["fiber"]{
                    self.fiber = fiber as? String
                }
                
                if let sugar = serving["sugar"]{
                    self.sugar = sugar as? String
                }
                
                if let vitamin_a = serving["vitamin_a"]{
                    self.vitamin_a = vitamin_a as? String
                }
                
                if let vitamin_c = serving["vitamin_c"]{
                    self.vitamin_c = vitamin_c as? String
                }
                
                if let calcium = serving["calcium"]{
                    self.calcium = calcium as? String
                }
                
                if let iron = serving["iron"]{
                    self.iron = iron as? String
                }
                
            }
        }
        
        if let recipe_category = json["recipe_categories"] {
            let recipe_categories = recipe_category as! [String: Any]
            var categoryDataSet: [CategoryData] = []
            if let category = recipe_categories["recipe_category"]{
                
                for(index, _) in (category as! NSArray).enumerated(){
                    let category_index = (category as! NSArray)[index] as! [String: AnyObject]
                    let category_name = category_index["recipe_category_name"] as! String
                    let category_url = category_index["recipe_category_url"] as! String
                    let categoryData = CategoryData(recipe_category_name: category_name, recipe_category_url: category_url)
                    categoryDataSet.append(categoryData)
                }
                
            }
            self.category = categoryDataSet
        }
        
        
        
        if let ingredients = json["ingredients"]{
            let ingred = ingredients as! [String: Any]
            var ingredientDataSet: [IngredientData] = []
            if let ingredient = ingred["ingredient"]{
                for(index, _) in (ingredient as! NSArray ).enumerated(){
                    let ingredient_index = (ingredient as! NSArray )[index] as! [String: AnyObject]
                    let food_id = ingredient_index["food_id"] as! String
                    let food_name = ingredient_index["food_name"] as! String
                    let serving_id = ingredient_index["serving_id"] as! String
                    let number_of_units = ingredient_index["number_of_units"] as! String
                    let ingredient_url = ingredient_index["ingredient_url"] as! String
                    let ingredient_description = ingredient_index["ingredient_description"] as! String
                    let measurement_description = ingredient_index["measurement_description"] as! String
                    
                    let ingredientData = IngredientData(food_id: food_id, food_name: food_name, serving_id: serving_id, number_of_units: number_of_units, ingredient_url: ingredient_url, ingredient_description: ingredient_description, measurement_description: measurement_description)
                    ingredientDataSet.append(ingredientData)
                }
            }
            self.ingredient = ingredientDataSet
            
        }
        
        
        
        if let directions = json["directions"]{
            let directs = directions as! [String: Any]
            var directionDataSet: [DirectionData] = []
            if let direction = directs["direction"] {
                if direction as? NSArray != nil{
                    for(index, _) in (direction as! NSArray).enumerated(){
                        let direction_index = (direction as! NSArray)[index] as! [String: AnyObject]
                        let direction_number = direction_index["direction_number"] as! String
                        let direction_description = direction_index["direction_description"] as! String
                        let directionData = DirectionData(direction_number: direction_number, direction_description: direction_description)
                        directionDataSet.append(directionData)
                    }
                }
                
            }
            self.direction = directionDataSet
        }
    }
    
    
}


class IngredientData {
    var food_id: String
    var food_name: String
    var serving_id: String
    var number_of_units: String
    var ingredient_url: String
    var ingredient_description: String
    var measurement_description: String
    
    
    
    init(food_id: String, food_name: String, serving_id: String, number_of_units: String, ingredient_url: String, ingredient_description: String, measurement_description: String) {
        self.food_id = food_id
        self.food_name = food_name
        self.serving_id = serving_id
        self.number_of_units = number_of_units
        self.ingredient_url = ingredient_url
        self.ingredient_description = ingredient_description
        self.measurement_description = measurement_description
    }
    
    
}


class CategoryData{
    var recipe_category_name: String
    var recipe_category_url: String
    
    
    
    init(recipe_category_name: String, recipe_category_url: String) {
        self.recipe_category_name = recipe_category_name
        self.recipe_category_url = recipe_category_url
    }
    
}

class DirectionData{
    var direction_number: String
    var direction_description: String
    
    
    
    init(direction_number: String, direction_description: String) {
        self.direction_number = direction_number
        self.direction_description = direction_description
    }
    
}

