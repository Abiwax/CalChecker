//
//  DetailViewController.swift
//  CalChecker
//
//  Created by Adeniran  Abisola on 2016-10-07.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController{
    
    var selectedRow = 0
    
    var foodDataSet: [FoodData] = []
    let calorieSetup = CalorieSetup()
    
    override func viewDidLoad() {
        getFoodData()
        self.tableView.reloadData()
    }
    
    func getFoodData(){
        calorieSetup.loadAllFood()
        self.foodDataSet = self.calorieSetup.foodDataSet
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodDataSet.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = foodDataSet[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = object.food_name
        return cell
    }
    
    override
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.displayActivityIndicator()
        selectedRow = (indexPath as NSIndexPath).row
        let foodData = foodDataSet[selectedRow]
        DispatchQueue.main.async(execute: {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SelectedViewController") as! SelectedViewController
            nextViewController.foodData = foodData
            self.navigationController?.pushViewController(nextViewController, animated: true)
        })
        
    }
    
    
    
    
}
