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
    
    var lists = [[String:String]]()
    var selectedrow = 0;
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    override func viewDidLoad() {
        let recipes = UserDefaults.standard.object(forKey: "Recipes")
        lists = recipes! as? [[String : String]] ?? [["recipe_image":"","recipe_name":"","recipe_description":""]]
        self.getSelected();
        tableView.reloadData();
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultViewCell
        let cellDetails = lists[(indexPath as NSIndexPath).row]
        
        let keyExists = cellDetails["recipe_image"] != nil
        if(keyExists)
        {
            let imageR = NSURL(string: cellDetails["recipe_image"]!)
            let imageData = NSData(contentsOf: imageR! as URL)
            cell.imageLabel.image = UIImage(data: (imageData)! as Data);
            let nameInfo = cellDetails["recipe_name"]
            let detailsInfo = cellDetails["recipe_description"]
            cell.namelabel.text = nameInfo
            cell.detailsLabel.text = detailsInfo
        }
        else
        {
            cell.imageLabel.image = UIImage(named: "download.jpeg");
            let nameInfo = cellDetails["recipe_name"]
            let detailsInfo = cellDetails["recipe_description"]
            cell.namelabel.text = nameInfo
            cell.detailsLabel.text = detailsInfo
        }
        
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedrow = (indexPath as NSIndexPath).row
        let rowValue = lists[selectedrow]
        let r_id = rowValue["recipe_id"]
        DispatchQueue.main.async(execute:{
            self.loadData(r_id: r_id!)
            UserDefaults.standard.set(rowValue, forKey: "selectedRecipe");
            UserDefaults.standard.synchronize();
        })
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "selectedR") as! RecipeViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    func loadData(r_id: String){
        let myURL:URL = URL(string: "http://abiwaxdesigns.com/api/FetchSelectedRecipe.php?search=\(r_id)")!
        var request = URLRequest(url: myURL);
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                UserDefaults.standard.set(json, forKey: "RecipeDetails")
                UserDefaults.standard.synchronize()
                
            }
        }
        task.resume()
        
    }
    
    func getSelected(){
        let details = UserDefaults.standard.object(forKey: "selectedCell") as! [String: String]
        self.foodName.text = details["food_name"]!
        let description = details["food_description"]!
        let serving = description.components(separatedBy: "-")
        self.gramDetailText.text = serving[0]
        let calDetails = serving[1].components(separatedBy: "|")[0].components(separatedBy: ":")[1];
        self.calDetailText.text = calDetails
    }
    
    
}
