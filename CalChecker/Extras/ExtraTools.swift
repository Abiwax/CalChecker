//
//  ExtraTools.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2017-03-22.
//  Copyright © 2017 Abisola Adeniran. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayActivityIndicator(){
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.startAnimating()
        let item = UIBarButtonItem(customView: indicator)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func dismissActivityIndicator(){
        self.navigationItem.rightBarButtonItem = nil
    }
}

