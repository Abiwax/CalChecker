//
//  SearchViewController.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2016-10-06.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit
class SearchViewController: UIViewController{
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var buttonText: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var infoText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad();
        infoText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sed tortor convallis, scelerisque dui sed, tincidunt velit. In non interdum massa. Sed justo erat, rhoncus eu felis in, viverra mollis arcu. Ut et magna eget lacus dictum sollicitudin. Etiam metus nisi, volutpat et eros nec, consectetur consectetur justo. Vivamus porttitor, dui eu suscipit gravida, enim ligula consectetur lorem, sed cursus dui ante ut justo. Proin tincidunt venenatis mauris sollicitudin sodales. Curabitur blandit dignissim efficitur. Nunc ligula dui, dapibus nec ipsum ac, sagittis lobortis enim. Maecenas vel est sed ipsum fermentum consectetur quis non enim. Nulla facilisi. Sed sit amet enim eget purus rhoncus mattis ut ac ex. Suspendisse ornare sapien in ligula vulputate, a fringilla mauris consequat. In aliquam ex vitae neque hendrerit tincidunt. Aenean felis sapien, laoreet a tortor ornare, gravida rhoncus turpis."
    }
    
    
    @IBAction func menuButton(_ sender: AnyObject) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "menuButton"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "closeMenuViaNotification"), object: nil)
        view.endEditing(true)
    }
    @IBAction func buttonSearch(_ sender: AnyObject) {
        let textValue = searchText.text
        if(textValue == ""){
            errorLabel.text = "This field is required"
            
        }
        else{
            let newText: String = textValue!.replacingOccurrences(of: " ", with: "")
            let myURL:URL = URL(string: "http://abiwaxdesigns.com/api/FetchCalData.php?search=\(newText)")!
            var request = URLRequest(url: myURL);
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let task = session.dataTask(with: request){ (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    
                    let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                    
                    let dictionary = json as? [String: Any]
                    let keyExists = dictionary!["food"] != nil
                    if(!keyExists){
                        DispatchQueue.main.async(execute: {
                            self.displayMyAlertMessage("We currently don't have that food, visit another time.");
                        })
                        
                    }
                    else{
                        let nestedArray = dictionary!["food"] as! NSArray
                        let nestedDictionary = nestedArray as! [[String: String]]
                        UserDefaults.standard.set(nestedDictionary, forKey: "FoodDetails");
                        UserDefaults.standard.set(textValue, forKey: "FoodName");
                        UserDefaults.standard.synchronize();
                        
                        DispatchQueue.main.async(execute: {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "listView") as! DetailViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        })
                        
                    }
                }
            }
            task.resume()
        }
        
        
    }
    
    func displayMyAlertMessage(_ userMessage: String)
    {
        let myAlert = UIAlertController(title: "No data", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
        
    }
    
}
