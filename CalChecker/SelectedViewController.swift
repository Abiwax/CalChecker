//
//  SelectedViewController.swift
//  CalChecker
//
//  Created by Adeniran  Abisola on 2016-10-07.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit

class SelectedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var foodName: UILabel!
    @IBOutlet var calDetailText: UILabel!
    @IBOutlet var gramDetailText: UILabel!
    @IBOutlet var tableView: UITableView!
    
    
    var selectedrow = 0;
    
    var foodData: FoodData!
    var recipeDataSet: [RecipeData] = []
    var calSetup = CalorieSetup()
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    override func viewDidLoad() {
        self.getSelected();
        tableView.reloadData();
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismissActivityIndicator()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipeDataSet.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultViewCell
        let recipeData = recipeDataSet[(indexPath as NSIndexPath).row]
        let nameInfo = recipeData.recipe_name
        let detailsInfo = recipeData.recipe_description
        cell.namelabel.text = nameInfo
        cell.detailsLabel.text = detailsInfo

        if let imageD = recipeData.recipe_image {
            if imageD != "" {
                let imageR = NSURL(string: imageD)
                let imageData = NSData(contentsOf: imageR! as URL)
                cell.imageLabel.image = UIImage(data: (imageData)! as Data);

            }
            else{
                cell.imageLabel.image = UIImage(named: "download.jpeg");
            }
        }
        else{
            cell.imageLabel.image = UIImage(named: "download.jpeg");
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.displayActivityIndicator()
        selectedrow = (indexPath as NSIndexPath).row
        let recipeData = recipeDataSet[selectedrow]
        let r_id = recipeData.recipe_id
        DispatchQueue.main.async(execute:{
            self.loadData(r_id: r_id)
        })
        
        
        
    }
        
    func loadData(r_id: String){
        
        let postString = "search=\(r_id)";
        let myURL:URL = URL(string: "http://127.0.0.1:4551/recipe")!
        var request = URLRequest(url: myURL);
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)!
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                
                let recipe_id = json?["recipe_id"] as! String
                let recipe_name = json?["recipe_name"] as! String
                let recipe_url = json?["recipe_url"] as! String
                let recipe_description = json?["recipe_description"] as! String
                let number_of_servings = json?["number_of_servings"] as! String
                let rating = json?["rating"] as! String
                var preparation_time_min = ""
                if let preparation_time = json?["preparation_time_min"] {
                    preparation_time_min = preparation_time as! String
                }
                var cooking_time_min = ""
                if let cooking_time = json?["cooking_time_min"] {
                    cooking_time_min = cooking_time as! String
                }
                
                let recipe_types = json?["recipe_types"] as! [String: Any]
                let recipe_type = recipe_types["recipe_type"] as! String
                let recipe_images = json?["recipe_images"] as! [String: Any]
                let recipe_image = recipe_images["recipe_image"] as! String
                let serving_types = json?["serving_sizes"] as! [String: Any]
                let serving = serving_types["serving"] as! [String: Any]
                let serving_size = serving["serving_size"] as! String
                let calories = serving["calories"] as! String
                let carbohydrate = serving["carbohydrate"] as! String
                let protein = serving["protein"] as! String
                let fat = serving["fat"] as! String
                let saturated_fat = serving["saturated_fat"] as! String
                let polyunsaturated_fat = serving["polyunsaturated_fat"] as! String
                let monounsaturated_fat = serving["monounsaturated_fat"] as! String
                let trans_fat = serving["trans_fat"] as! String
                let cholesterol = serving["cholesterol"] as! String
                let sodium = serving["sodium"] as! String
                let potassium = serving["potassium"] as! String
                let fiber = serving["fiber"] as! String
                let sugar = serving["sugar"] as! String
                let vitamin_a = serving["vitamin_a"] as! String
                let vitamin_c = serving["vitamin_c"] as! String
                let calcium = serving["calcium"] as! String
                let iron = serving["iron"] as! String
                
                let recipe_category = json?["recipe_categories"] as! [String: Any]
                var categoryDataSet: [CategoryData] = []
                let category = recipe_category["recipe_category"] as! NSArray
                for(index, _) in category.enumerated(){
                    let category_index = category[index] as! [String: AnyObject]
                    let category_name = category_index["recipe_category_name"] as! String
                    let category_url = category_index["recipe_category_url"] as! String
                    let categoryData = CategoryData(recipe_category_name: category_name, recipe_category_url: category_url)
                    categoryDataSet.append(categoryData)
                }
                
                let ingredients = json?["ingredients"] as! [String: Any]
                var ingredientDataSet: [IngredientData] = []
                let ingredient = ingredients["ingredient"] as! NSArray
                for(index, _) in ingredient.enumerated(){
                    let ingredient_index = ingredient[index] as! [String: AnyObject]
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

                let directions = json?["directions"] as! [String: Any]
                var directionDataSet: [DirectionData] = []
                let direction = directions["direction"] as! NSArray
                for(index, _) in direction.enumerated(){
                    let direction_index = direction[index] as! [String: AnyObject]
                    let direction_number = direction_index["direction_number"] as! String
                    let direction_description = direction_index["direction_description"] as! String
                    let directionData = DirectionData(direction_number: direction_number, direction_description: direction_description)
                    directionDataSet.append(directionData)
                }


                let ingredientSet = ingredientDataSet
                let directionSet = directionDataSet
                let categorySet = categoryDataSet
                
                let recipeInfo = RecipeInfo(recipe_id: recipe_id, recipe_name: recipe_name, recipe_url: recipe_url, recipe_description: recipe_description, number_of_servings: number_of_servings, preparation_time_min: preparation_time_min, cooking_time_min: cooking_time_min, rating: rating, recipe_type: recipe_type, recipe_image: recipe_image, serving_size: serving_size, calories: calories, carbohydrate: carbohydrate, protein: protein, fat: fat, saturated_fat: saturated_fat, polyunsaturated_fat: polyunsaturated_fat, monounsaturated_fat: monounsaturated_fat, trans_fat: trans_fat, cholesterol: cholesterol, sodium: sodium, potassium: potassium, fiber: fiber, sugar: sugar, vitamin_a: vitamin_a, vitamin_c: vitamin_c, calcium: calcium, iron: iron, direction: directionSet, ingredient: ingredientSet, category: categorySet)
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeViewController") as! RecipeViewController
                nextViewController.recipeInfo = recipeInfo
                self.navigationController?.pushViewController(nextViewController, animated: true)
                
            }
        }
        task.resume()
        
    }
    
    func getSelected(){
        self.foodName.text = foodData.food_name
        let description = foodData.food_description
        let serving = description.components(separatedBy: "-")
        self.gramDetailText.text = serving[0]
        let calDetails = serving[1].components(separatedBy: "|")[0].components(separatedBy: ":")[1];
        self.calDetailText.text = calDetails
        self.calSetup.loadAllRecipe()
        self.recipeDataSet = self.calSetup.recipeDataSet
    }
    
    
}
