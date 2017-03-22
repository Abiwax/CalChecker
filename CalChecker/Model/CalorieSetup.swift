//
//  CalorieSetup.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2017-03-22.
//  Copyright © 2017 Abisola Adeniran. All rights reserved.
//

import UIKit

class CalorieSetup {
    
    var foodDataSet: [FoodData] = []
    var recipeDataSet: [RecipeData] = []
    var recipeInfoDataSet: [RecipeInfo] = []
    
    
    // add Food to a list of FoodData
    func addFood(foodData: FoodData){
        foodDataSet.append(foodData)
    }
    
    //save all Food data into local storage
    func saveFood(){
        var items: [Data] = []
        for foodData in foodDataSet {
            let item = NSKeyedArchiver.archivedData(withRootObject: foodData)
            items.append(item)
            
        }
        UserDefaults.standard.set(items, forKey: UserDefaultKeys.foodData)
    }
    
    //get all data from
    func loadAllFood(){
        foodDataSet = []
        guard let savedFood = UserDefaults.standard.array(forKey: UserDefaultKeys.foodData) else { return }
        for savedData in savedFood{
            guard let foodData = NSKeyedUnarchiver.unarchiveObject(with: savedData as! Data) as? FoodData else { continue }
            addFood(foodData: foodData)
        }
    }
    
    func removeFood(indexInArray: Int){
        foodDataSet.remove(at: indexInArray)
        saveFood()
    }
    
    func removeAllFood(){
        foodDataSet.removeAll()
        saveFood()
    }
    
    
    // add Recipe to a list of RecipeData
    func addRecipe(recipeData: RecipeData){
        recipeDataSet.append(recipeData)
    }
    
    //save all Recipe data into local storage
    func saveRecipe(){
        var items: [Data] = []
        for recipeData in recipeDataSet {
            let item = NSKeyedArchiver.archivedData(withRootObject: recipeData)
            items.append(item)
            
        }
        UserDefaults.standard.set(items, forKey: UserDefaultKeys.recipeData)
    }
    
    //get all data from
    func loadAllRecipe(){
        recipeDataSet = []
        guard let savedRecipe = UserDefaults.standard.array(forKey: UserDefaultKeys.recipeData) else { return }
        for savedData in savedRecipe{
            guard let recipeData = NSKeyedUnarchiver.unarchiveObject(with: savedData as! Data) as? RecipeData else { continue }
            addRecipe(recipeData: recipeData)
        }
    }
    
    func removeRecipe(indexInArray: Int){
        recipeDataSet.remove(at: indexInArray)
        saveRecipe()
    }
    
    func removeAllRecipe(){
        recipeDataSet.removeAll()
        saveRecipe()
    }
    
    // add RecipeInfo to a list of RecipeInfo
    func addRecipeInfo(recipeInfoData: RecipeInfo){
        recipeInfoDataSet.append(recipeInfoData)
    }
    
    //save all RecipeInfo Info data into local storage
    func saveRecipeInfo(){
        var items: [Data] = []
        for recipeInfoData in recipeInfoDataSet {
            let item = NSKeyedArchiver.archivedData(withRootObject: recipeInfoData)
            items.append(item)
            
        }
        UserDefaults.standard.set(items, forKey: UserDefaultKeys.recipeInfo)
    }
    
    //get all data from
    func loadAllRecipeInfo(){
        recipeInfoDataSet = []
        guard let savedRecipeInfo = UserDefaults.standard.array(forKey: UserDefaultKeys.recipeInfo) else { return }
        for savedData in savedRecipeInfo{
            guard let recipeInfoData = NSKeyedUnarchiver.unarchiveObject(with: savedData as! Data) as? RecipeInfo else { continue }
            addRecipeInfo(recipeInfoData: recipeInfoData)
        }
    }
    
    func removeRecipeInfo(indexInArray: Int){
        recipeInfoDataSet.remove(at: indexInArray)
        saveRecipeInfo()
    }
    
    func removeAllRecipeInfo(){
        recipeInfoDataSet.removeAll()
        saveRecipeInfo()
    }
}

struct UserDefaultKeys {
    static let foodData = "foodData"
    static let recipeData = "recipeData"
    static let recipeInfo = "recipeInfo"
}

