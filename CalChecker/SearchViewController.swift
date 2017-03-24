//
//  SearchViewController.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2016-10-06.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var buttonText: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    let calSetup = CalorieSetup()
    
    @IBOutlet var tableView: UITableView!
    
    var recentSearch:[Search] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.dataSource = self
        tableView.delegate = self
        
        self.readSearch()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismissActivityIndicator()
    }
    
    
//    @IBAction func menuButton(_ sender: AnyObject) {
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "menuButton"), object: nil)
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "closeMenuViaNotification"), object: nil)
//        view.endEditing(true)
//    }
    
    @IBAction func buttonSearcch(_ sender: UIButton) {
        self.displayActivityIndicator()
        let textValue = searchText.text
        if(textValue == ""){
            errorLabel.isHidden = false
            errorLabel.text = "This field is required"
            self.dismissActivityIndicator()
            
        }
        else{
            do{
                try writeSearch()
            }
            catch {
                print("Not working")
            }
            let newText: String = textValue!.replacingOccurrences(of: " ", with: "")
            self.getFood(food: newText)
            
        }
    }

    func getFood(food: String){
        let postString = "search=\(food)";
        let myURL:URL = URL(string: "http://127.0.0.1:4551/food")!
        var request = URLRequest(url: myURL);
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)!
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                let dictionary = json as? [String: Any]
                let keyExists = dictionary!["food"] != nil
                self.calSetup.foodDataSet = []
                if(!keyExists){
                    DispatchQueue.main.async(execute: {
                        self.displayMyAlertMessage("We currently don't have that food, visit another time.");
                    })
                    
                }
                else{
                    let nestedArray = dictionary!["food"] as! NSArray
                    
                    for(index, _) in nestedArray.enumerated(){
                        let food_index = nestedArray[index] as! [String: AnyObject]
                        
                        let food_id = food_index["food_id"] as! String
                        let food_name = food_index["food_name"] as! String
                        let food_url = food_index["food_url"] as! String
                        let food_description = food_index["food_description"] as! String
                        let food_type = food_index["food_type"] as! String
                        
                        let foodData = FoodData(food_id: food_id, food_name: food_name, food_url: food_url, food_description: food_description, food_type: food_type)
                        self.calSetup.addFood(foodData: foodData)
                    }
                    self.calSetup.saveFood()
                    
                    self.recipeSearch(post: postString)
                    
                }
            }
        }
        task.resume()
    }
    
    func recipeSearch(post: String){
        let postString = post;
        
        let myURL:URL = URL(string: "http://127.0.0.1:4551/recipes")!
        var request = URLRequest(url: myURL);
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)!
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                
                let dictionary = json as? [String: Any]
                
                let keyExists = dictionary!["recipe"] != nil
                
                if(keyExists){
                    let nestedArray = dictionary!["recipe"] as! NSArray
                    
                    self.calSetup.recipeDataSet = []
                    for(index, _) in nestedArray.enumerated(){
                        let recipe_index = nestedArray[index] as! [String: AnyObject]
                        
                        let recipe_id = recipe_index["recipe_id"] as! String
                        let recipe_name = recipe_index["recipe_name"] as! String
                        let recipe_url = recipe_index["recipe_url"] as! String
                        let recipe_description = recipe_index["recipe_description"] as! String
                        var recipe_image = ""
                        if let recipe_img = recipe_index["recipe_image"]{
                            recipe_image = recipe_img as! String
                            
                        }
                        
                        let recipeData = RecipeData(recipe_id: recipe_id, recipe_name: recipe_name, recipe_url: recipe_url, recipe_description: recipe_description, recipe_image: recipe_image )
                        self.calSetup.addRecipe(recipeData: recipeData)
                    }
                    self.calSetup.saveRecipe()
                    
                    DispatchQueue.main.async {
                        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                        self.navigationController?.pushViewController(nextViewController, animated: false)
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func displayMyAlertMessage(_ userMessage: String)
    {
        let myAlert = UIAlertController(title: "No data", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
        
    }
    
    func saveContext() throws {
        let context = persistentContainer?.viewContext
        if context!.hasChanges{
            try context!.save()
        }
    }
    
    func writeSearch() throws {
        let context = persistentContainer?.viewContext
        let search = Search(context: context!)
        if let searchval = searchText.text {
            search.searchstring = searchval
            do {
                try saveContext()
            }
            catch {
                print("unable to save")
            }
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = recentSearch[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = object.searchstring
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.displayActivityIndicator()
        let selectedRow = (indexPath as NSIndexPath).row
        let search = recentSearch[selectedRow]
        self.getFood(food: search.searchstring!)
        
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.deleteSearch(search: self.recentSearch[index.row])
            
        }
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Most Recent Searches"
    }
    
    func readSearch() {
        let context = persistentContainer!.viewContext
        let searchRequest: NSFetchRequest<Search> = Search.fetchRequest()
        do {
            let searches = try context.fetch(searchRequest)
            recentSearch = searches
            if recentSearch.count > 0{
                tableView.isHidden = false
                tableView.reloadData()
            }
//            for item in searches {
//                print(item.searchstring!)
//            }
        }
        catch {
            print("unable to save")
        }
        
    }
    
    func deleteSearch(search: Search){
        let context = persistentContainer!.viewContext
        
        if let result = try? context.existingObject(with: search.objectID) {
            context.delete(result)
            do {
                try saveContext()
            }
            catch {
                print("unable to save")
            }
        }
        
        self.readSearch()
    }
    
}
