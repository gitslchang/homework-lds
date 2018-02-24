//
//  UIKitExtensions.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import UIKit

extension UIColor {
    class func fromHex(_ rgbValue: UInt32) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(1))
    }
}
