//
//  DetailViewController.swift
//  CalChecker
//
//  Created by Adeniran  Abisola on 2016-10-07.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController{
    
    var items = [[String:String]]()
    var selectedRow = 0
    override func viewDidLoad() {
        self.getRecipe();
        let details = UserDefaults.standard.object(forKey: "FoodDetails")
        items = details! as! [[String : String]]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = items[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = object["food_name"]
        return cell
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = (indexPath as NSIndexPath).row
        let rowValue = items[selectedRow]
        UserDefaults.standard.set(rowValue, forKey: "selectedCell");
        UserDefaults.standard.synchronize();
        DispatchQueue.main.async(execute: {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "selectedView") as! SelectedViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        })
        
    }
    
    func getRecipe(){
        let foodvalue = UserDefaults.standard.string(forKey: "FoodName");
        let myURL:URL = URL(string: "http://abiwaxdesigns.com/api/FetchRecipeData.php?search=\(foodvalue!)")!
        var request = URLRequest(url: myURL);
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                let dictionary = json as? [String: Any]
                let keyExists = dictionary!["recipe"] != nil
                if(keyExists){
                    let nestedArray = dictionary!["recipe"] as! NSArray
                    let nestedDictionary = nestedArray as! [[String: String]]
                    DispatchQueue.main.async(execute: {
                        UserDefaults.standard.set(nestedDictionary, forKey: "Recipes");
                        UserDefaults.standard.synchronize();
                        
                    })
                    
                }
            }
        }
        task.resume()
        
    }
    
}
