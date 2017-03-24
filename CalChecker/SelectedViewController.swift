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
                
                let recipeInfo = RecipeInfo(json: json!)
                print(json)
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
