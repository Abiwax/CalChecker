//
//  URLConnect.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2016-11-21.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import UIKit

class URLConnect{
    
    func number(section: Int) -> Int {
        
        guard let device = DevicesEnum(rawValue: section) else {
            fatalError()
        }
        
        let number: Int
        switch device{
        case .Ipod:
            number = 12
        case .Iphone:
            number = 2
        }
        
        return number
    }
    
}

enum DevicesEnum: Int{
    case Ipod
    case Iphone
}
