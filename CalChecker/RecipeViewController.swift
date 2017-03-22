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
    
    var recipeInfo: RecipeInfo!
    
    override func viewDidLoad() {
        DispatchQueue.main.async(execute:{
            self.fillView();
        });
    }
    
    
    func fillView(){
        
        let cook_time : String = {
            var time: String!
            if let cook_time_min = recipeInfo.cooking_time_min {
                time = cook_time_min
            }
            else if let cook_time_min = recipeInfo.preparation_time_min {
                time = cook_time_min
                
            }
            else{
                time = ""
            }
            
            return time
        }()
        
        self.timeLabel.text = cook_time + " mins"
        
        guard let no_persons = recipeInfo.number_of_servings else { return }
        self.servingsLabel.text = no_persons;
        
        guard let calories = recipeInfo.calories else { return }
        self.caloriesLabel.text = calories
        
        
        let r_name = recipeInfo.recipe_name
        let r_desc = recipeInfo.recipe_description
        
        self.nameValue.text = r_name;
        self.detailsValue.text = r_desc
        
        if let imageData = recipeInfo.recipe_image {
            let imageR = NSURL(string: imageData)
            let imageData = NSData(contentsOf: imageR! as URL)
            self.imageDetails.image = UIImage(data: (imageData)! as Data);
        }
        else{
            self.imageDetails.image = UIImage(named: "download.jpeg");
        }
        
    
        
    }
    

}
