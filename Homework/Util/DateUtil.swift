//
//  DateUtil.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import Foundation

class DateHelper: NSObject {
    
    class func stringToDate(string: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "MST")
        return formatter.date(from: string)
    }
    
}
