//
//  SentientBeingMO.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import Foundation

extension SentientBeing {
    
    func fullNameDisplay() -> String {
        return (firstName ?? "") + " " + (lastName ?? "")
    }
    
    func affiliationDisplay() -> String {
        if let aff = affiliation {
            let str = aff.replacingOccurrences(of: "_", with: " ")
            return str.capitalized
        }
        return ""
    }
    
    func birthdateDisplay() -> String {
        if let bday = birthdate {
            if let bdate = DateHelper.stringToDate(string: bday, format: "yyyy-MM-dd") {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                return formatter.string(from: bdate)
            }
        }
        return ""
    }
}
