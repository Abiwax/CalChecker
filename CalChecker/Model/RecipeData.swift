//
//  RecipeData.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2017-03-22.
//  Copyright © 2017 Abisola Adeniran. All rights reserved.
//

import UIKit
struct RecipeDataKeys {
    static let recipe_id = "recipe_id"
    static let recipe_name = "recipe_name"
    static let recipe_url = "recipe_url"
    static let recipe_description = "recipe_description"
    static let recipe_image = "recipe_image"
}


class RecipeData: NSObject, NSCoding {
    var recipe_id: String
    var recipe_name: String
    var recipe_url: String
    var recipe_description: String
    var recipe_image: String?
    
    
    
    init(recipe_id: String, recipe_name: String, recipe_url: String, recipe_description: String, recipe_image: String) {
       self.recipe_id = recipe_id
        self.recipe_name = recipe_name
        self.recipe_url = recipe_url
        self.recipe_description = recipe_description
        self.recipe_image = recipe_image
    }
    
    
    //required for NSCoding
    required init?(coder decoder: NSCoder) {
        recipe_id = decoder.decodeObject(forKey: RecipeDataKeys.recipe_id) as! String
        recipe_name = decoder.decodeObject(forKey: RecipeDataKeys.recipe_name) as! String
        recipe_url = decoder.decodeObject(forKey: RecipeDataKeys.recipe_url) as! String
        recipe_description = decoder.decodeObject(forKey: RecipeDataKeys.recipe_description) as! String
        recipe_image = decoder.decodeObject(forKey: RecipeDataKeys.recipe_image) as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(recipe_id, forKey: RecipeDataKeys.recipe_id)
        coder.encode(recipe_name, forKey: RecipeDataKeys.recipe_name)
        coder.encode(recipe_url, forKey: RecipeDataKeys.recipe_url)
        coder.encode(recipe_description, forKey: RecipeDataKeys.recipe_description)
        coder.encode(recipe_image, forKey: RecipeDataKeys.recipe_image)
    }
}


