//
//  RecipeInfo.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2017-03-22.
//  Copyright © 2017 Abisola Adeniran. All rights reserved.
//

import UIKit


struct RecipeInfoKeys {
    static let recipe_id = "recipe_id"
    static let recipe_name = "recipe_name"
    static let recipe_url = "recipe_url"
    static let recipe_description = "recipe_description"
    static let number_of_servings = "number_of_servings"
    static let preparation_time_min = "preparation_time_min"
    static let cooking_time_min = "cooking_time_min"
    static let rating = "rating"
    static let recipe_type = "recipe_type"
    static let recipe_image = "recipe_image"
    static let serving_size = "serving_size"
    static let calories = "calories"
    static let carbohydrate = "carbohydrate"
    static let protein = "protein"
    static let fat = "fat"
    static let saturated_fat = "saturated_fat"
    static let polyunsaturated_fat = "polyunsaturated_fat"
    static let monounsaturated_fat = "monounsaturated_fat"
    static let trans_fat = "trans_fat"
    static let cholesterol = "cholesterol"
    static let sodium = "sodium"
    static let potassium = "potassium"
    static let fiber = "fiber"
    static let sugar = "sugar"
    static let vitamin_a = "vitamin_a"
    static let vitamin_c = "vitamin_c"
    static let calcium = "calcium"
    static let iron = "iron"
    static let ingredient = "ingredient"
    static let direction = "direction"
    static let category = "category"
}



class RecipeInfo: NSObject, NSCoding {
    var recipe_id: String
    var recipe_name: String
    var recipe_url: String
    var recipe_description: String
    var number_of_servings: String?
    var preparation_time_min: String?
    var cooking_time_min: String?
    var rating: String
    var recipe_type: String
    var recipe_image: String?
    var serving_size: String
    var calories: String?
    var carbohydrate: String
    var protein: String
    var fat: String
    var saturated_fat: String
    var polyunsaturated_fat: String
    var monounsaturated_fat: String
    var trans_fat: String
    var cholesterol: String
    var sodium: String
    var potassium: String
    var fiber: String
    var sugar: String
    var vitamin_a: String
    var vitamin_c: String
    var calcium: String
    var iron: String
    var ingredient: [IngredientData]
    var direction: [DirectionData]
    var category: [CategoryData]
    
    
    
    
    init(recipe_id: String, recipe_name: String, recipe_url: String, recipe_description: String, number_of_servings: String, preparation_time_min: String, cooking_time_min: String, rating: String, recipe_type: String, recipe_image: String, serving_size: String, calories: String, carbohydrate: String, protein: String, fat: String, saturated_fat: String, polyunsaturated_fat: String, monounsaturated_fat: String, trans_fat: String, cholesterol: String, sodium: String, potassium: String, fiber: String, sugar: String, vitamin_a: String, vitamin_c: String, calcium: String, iron: String, direction: [DirectionData], ingredient: [IngredientData], category: [CategoryData]) {
        
        self.recipe_id = recipe_id
        self.recipe_name = recipe_name
        self.recipe_url = recipe_url
        self.recipe_description = recipe_description
        self.number_of_servings = number_of_servings
        self.preparation_time_min = preparation_time_min
        self.cooking_time_min = cooking_time_min
        self.rating = rating
        self.recipe_type = recipe_type
        self.recipe_image = recipe_image
        self.serving_size = serving_size
        self.calories = calories
        self.carbohydrate = carbohydrate
        self.protein = protein
        self.fat = fat
        self.saturated_fat = saturated_fat
        self.polyunsaturated_fat = polyunsaturated_fat
        self.monounsaturated_fat = monounsaturated_fat
        self.trans_fat = trans_fat
        self.cholesterol = cholesterol
        self.sodium = sodium
        self.potassium = potassium
        self.fiber = fiber
        self.sugar = sugar
        self.vitamin_a = vitamin_a
        self.vitamin_c = vitamin_c
        self.calcium = calcium
        self.iron = iron
        self.ingredient = ingredient
        self.direction = direction
        self.category = category
    }
    
    
    //required for NSCoding
    required init?(coder decoder: NSCoder) {
        recipe_id = decoder.decodeObject(forKey: RecipeInfoKeys.recipe_id) as! String
        recipe_name = decoder.decodeObject(forKey: RecipeInfoKeys.recipe_name) as! String
        recipe_url = decoder.decodeObject(forKey: RecipeInfoKeys.recipe_url) as! String
        recipe_description = decoder.decodeObject(forKey: RecipeInfoKeys.recipe_description) as! String
        number_of_servings = decoder.decodeObject(forKey: RecipeInfoKeys.number_of_servings) as? String
        preparation_time_min = decoder.decodeObject(forKey: RecipeInfoKeys.preparation_time_min) as? String
        cooking_time_min = decoder.decodeObject(forKey: RecipeInfoKeys.cooking_time_min) as? String
        rating = decoder.decodeObject(forKey: RecipeInfoKeys.rating) as! String
        recipe_type = decoder.decodeObject(forKey: RecipeInfoKeys.recipe_type) as! String
        recipe_image = decoder.decodeObject(forKey: RecipeInfoKeys.recipe_image) as? String
        serving_size = decoder.decodeObject(forKey: RecipeInfoKeys.serving_size) as! String
        calories = decoder.decodeObject(forKey: RecipeInfoKeys.calories) as? String
        carbohydrate = decoder.decodeObject(forKey: RecipeInfoKeys.carbohydrate) as! String
        protein = decoder.decodeObject(forKey: RecipeInfoKeys.protein) as! String
        fat = decoder.decodeObject(forKey: RecipeInfoKeys.fat) as! String
        saturated_fat = decoder.decodeObject(forKey: RecipeInfoKeys.saturated_fat) as! String
        polyunsaturated_fat = decoder.decodeObject(forKey: RecipeInfoKeys.polyunsaturated_fat) as! String
        monounsaturated_fat = decoder.decodeObject(forKey: RecipeInfoKeys.monounsaturated_fat) as! String
        trans_fat = decoder.decodeObject(forKey: RecipeInfoKeys.trans_fat) as! String
        cholesterol = decoder.decodeObject(forKey: RecipeInfoKeys.cholesterol) as! String
        sodium = decoder.decodeObject(forKey: RecipeInfoKeys.sodium) as! String
        potassium = decoder.decodeObject(forKey: RecipeInfoKeys.potassium) as! String
        fiber = decoder.decodeObject(forKey: RecipeInfoKeys.fiber) as! String
        sugar = decoder.decodeObject(forKey: RecipeInfoKeys.sugar) as! String
        vitamin_a = decoder.decodeObject(forKey: RecipeInfoKeys.vitamin_a) as! String
        vitamin_c = decoder.decodeObject(forKey: RecipeInfoKeys.vitamin_c) as! String
        calcium = decoder.decodeObject(forKey: RecipeInfoKeys.calcium) as! String
        iron = decoder.decodeObject(forKey: RecipeInfoKeys.iron) as! String
        ingredient = decoder.decodeObject(forKey: RecipeInfoKeys.ingredient) as! [IngredientData]
        direction = decoder.decodeObject(forKey: RecipeInfoKeys.direction) as! [DirectionData]
        category = decoder.decodeObject(forKey: RecipeInfoKeys.category) as! [CategoryData]
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(recipe_id, forKey: RecipeInfoKeys.recipe_id)
        coder.encode(recipe_name, forKey: RecipeInfoKeys.recipe_name)
        coder.encode(recipe_url, forKey: RecipeInfoKeys.recipe_url)
        coder.encode(recipe_description, forKey: RecipeInfoKeys.recipe_description)
        coder.encode(number_of_servings, forKey: RecipeInfoKeys.number_of_servings)
        coder.encode(preparation_time_min, forKey: RecipeInfoKeys.preparation_time_min)
        coder.encode(cooking_time_min, forKey: RecipeInfoKeys.cooking_time_min)
        coder.encode(rating, forKey: RecipeInfoKeys.rating)
        coder.encode(recipe_type, forKey: RecipeInfoKeys.recipe_type)
        coder.encode(recipe_image, forKey: RecipeInfoKeys.recipe_image)
        coder.encode(serving_size, forKey: RecipeInfoKeys.serving_size)
        coder.encode(calories, forKey: RecipeInfoKeys.calories)
        coder.encode(carbohydrate, forKey: RecipeInfoKeys.carbohydrate)
        coder.encode(protein, forKey: RecipeInfoKeys.protein)
        coder.encode(fat, forKey: RecipeInfoKeys.fat)
        coder.encode(saturated_fat, forKey: RecipeInfoKeys.saturated_fat)
        coder.encode(polyunsaturated_fat, forKey: RecipeInfoKeys.polyunsaturated_fat)
        coder.encode(monounsaturated_fat, forKey: RecipeInfoKeys.monounsaturated_fat)
        coder.encode(trans_fat, forKey: RecipeInfoKeys.trans_fat)
        coder.encode(cholesterol, forKey: RecipeInfoKeys.cholesterol)
        coder.encode(sodium, forKey: RecipeInfoKeys.sodium)
        coder.encode(potassium, forKey: RecipeInfoKeys.potassium)
        coder.encode(fiber, forKey: RecipeInfoKeys.fiber)
        coder.encode(sugar, forKey: RecipeInfoKeys.sugar)
        coder.encode(vitamin_a, forKey: RecipeInfoKeys.vitamin_a)
        coder.encode(vitamin_c, forKey: RecipeInfoKeys.vitamin_c)
        coder.encode(calcium, forKey: RecipeInfoKeys.calcium)
        coder.encode(iron, forKey: RecipeInfoKeys.iron)
        coder.encode(ingredient, forKey: RecipeInfoKeys.ingredient)
        coder.encode(direction, forKey: RecipeInfoKeys.direction)
        coder.encode(category, forKey: RecipeInfoKeys.category)
    }
}


struct IngredientDataKeys {
    static let food_id = "serving_id"
    static let food_name = "number_of_units"
    static let serving_id = "serving_id"
    static let number_of_units = "number_of_units"
    static let ingredient_url = "ingredient_url"
    static let ingredient_description = "ingredient_description"
    static let measurement_description = "measurement_description"
}


class IngredientData: NSObject, NSCoding {
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
    
    
    //required for NSCoding
    required init?(coder decoder: NSCoder) {
        food_id = decoder.decodeObject(forKey: IngredientDataKeys.food_id) as! String
        food_name = decoder.decodeObject(forKey: IngredientDataKeys.food_name) as! String
        serving_id = decoder.decodeObject(forKey: IngredientDataKeys.serving_id) as! String
        number_of_units = decoder.decodeObject(forKey: IngredientDataKeys.number_of_units) as! String
        ingredient_url = decoder.decodeObject(forKey: IngredientDataKeys.ingredient_url) as! String
        ingredient_description = decoder.decodeObject(forKey: IngredientDataKeys.ingredient_description) as! String
        measurement_description = decoder.decodeObject(forKey: IngredientDataKeys.measurement_description) as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(food_id, forKey: IngredientDataKeys.food_id)
        coder.encode(food_name, forKey: IngredientDataKeys.food_name)
        coder.encode(serving_id, forKey: IngredientDataKeys.serving_id)
        coder.encode(number_of_units, forKey: IngredientDataKeys.number_of_units)
        coder.encode(ingredient_url, forKey: IngredientDataKeys.ingredient_url)
        coder.encode(ingredient_description, forKey: IngredientDataKeys.ingredient_description)
        coder.encode(measurement_description, forKey: IngredientDataKeys.measurement_description)
    }
}

struct CategoryDataKeys {
    static let recipe_category_name = "recipe_category_name"
    static let recipe_category_url = "recipe_category_url"
}


class CategoryData: NSObject, NSCoding {
    var recipe_category_name: String
    var recipe_category_url: String
    
    
    
    init(recipe_category_name: String, recipe_category_url: String) {
        self.recipe_category_name = recipe_category_name
        self.recipe_category_url = recipe_category_url
    }
    
    
    //required for NSCoding
    required init?(coder decoder: NSCoder) {
        recipe_category_name = decoder.decodeObject(forKey: CategoryDataKeys.recipe_category_name) as! String
        recipe_category_url = decoder.decodeObject(forKey: CategoryDataKeys.recipe_category_url) as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(recipe_category_name, forKey: CategoryDataKeys.recipe_category_name)
        coder.encode(recipe_category_name, forKey: CategoryDataKeys.recipe_category_url)
    }
}

struct DirectionDataKeys {
    static let direction_number = "direction_number"
    static let direction_description = "direction_description"
}


class DirectionData: NSObject, NSCoding {
    var direction_number: String
    var direction_description: String
    
    
    
    init(direction_number: String, direction_description: String) {
        self.direction_number = direction_number
        self.direction_description = direction_description
    }
    
    
    //required for NSCoding
    required init?(coder decoder: NSCoder) {
        direction_number = decoder.decodeObject(forKey: DirectionDataKeys.direction_number) as! String
        direction_description = decoder.decodeObject(forKey: DirectionDataKeys.direction_description) as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(direction_number, forKey: DirectionDataKeys.direction_number)
        coder.encode(direction_number, forKey: DirectionDataKeys.direction_description)
    }
}

