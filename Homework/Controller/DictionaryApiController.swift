//
//  DictionaryApiController.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import Foundation
import CoreData

protocol ApiControllerProtocol {
    func didReceiveResults()
    func didReceiveError()
}

class DictionaryApiController {
    
    var baseApiUrl: String!
    var myDict: NSDictionary?
    var delegate: ApiControllerProtocol!
    
    init(delegate: ApiControllerProtocol) {
        self.delegate = delegate
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            self.myDict = NSDictionary(contentsOfFile: path)
        }
        
    }
}
