//
//  MenuOptions.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2016-10-06.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit

class MenuOptions : UITableViewController {
    
    let menuValues = ["Search by Text"]
    
}

extension MenuOptions {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath as NSIndexPath).row {
        case 0:
            NotificationCenter.default.post(name: Notification.Name(rawValue: "openView"), object: nil)
        default:
            print("indexPath.row:: \((indexPath as NSIndexPath).row)")
        }
        
        // also close the menu
        NotificationCenter.default.post(name: Notification.Name(rawValue: "closeMenuViaNotification"), object: nil)
        
    }
    
}

// MARK: - UITableViewDataSource methods

extension MenuOptions {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuValues[(indexPath as NSIndexPath).row]
        return cell
    }
    
}
