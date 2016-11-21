//
//  RecipeViewController.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2016-10-07.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController{
    
    @IBOutlet var imageDetails: UIImageView!
    @IBOutlet var nameValue: UILabel!
    @IBOutlet var detailsValue: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var servingsLabel: UILabel!
    
    override func viewDidLoad() {
        DispatchQueue.main.async(execute:{
            self.fillView();
        });
    }
    
    
    func fillView(){
        let recipe = UserDefaults.standard.object(forKey: "selectedRecipe") as! [String: String]
        let dictionary = UserDefaults.standard.dictionary(forKey: "RecipeDetails")
        if(dictionary != nil){
            let keyExistsCe = dictionary!["cooking_time_min"] != nil
            let keyExistsPe = dictionary!["preparation_time_min"] != nil
            if(keyExistsCe){
                let cook_time = dictionary!["cooking_time_min"] as! String
                self.timeLabel.text = cook_time + " mins"
            }
            else if(keyExistsPe){
                let cook_time = dictionary!["preparation_time_min"] as! String
                self.timeLabel.text = cook_time + " mins"
            }
            else{
                self.timeLabel.text = ""
            }
            let keyExistsNo = dictionary!["number_of_servings"] != nil;
            if(keyExistsNo){
                let no_persons = dictionary!["number_of_servings"] as! String;
                self.servingsLabel.text = no_persons;
            }
            else{
                self.servingsLabel.text = "";
            }
            let keyExistsSe = dictionary!["serving_sizes"] != nil
            if(keyExistsSe){
                let serving_size = dictionary!["serving_sizes"] as! [String: Any]
                let serving = serving_size["serving"] as! [String: String]
                self.caloriesLabel.text = serving["calories"]
                
            }else{
                self.caloriesLabel.text = ""
            }
            self.loadDetails(recipeDetails: recipe)
        }
        else{
            self.loadDetails(recipeDetails: recipe)
            self.timeLabel.text = "Loading ...."
            self.servingsLabel.text = "Loading ...."
            self.caloriesLabel.text = "Loading ...."
        }
    }
    
    
    func loadDetails(recipeDetails: [String: String]){
        let recipe = recipeDetails
        let r_name = recipe["recipe_name"]
        let r_desc = recipe["recipe_description"]
        self.nameValue.text = r_name;
        self.detailsValue.text = r_desc
        let keyExistsImage = recipe["recipe_image"] != nil
        if(keyExistsImage){
            let r_img = recipe["recipe_image"]
            let imageR = NSURL(string: r_img!)
            let imageData = NSData(contentsOf: imageR! as URL)
            self.imageDetails.image = UIImage(data: (imageData)! as Data);
        }
        else{
            let r_img = UIImage(named: "download.jpeg");
            self.imageDetails.image = r_img
        }
    }
}
