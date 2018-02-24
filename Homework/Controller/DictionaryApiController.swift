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

struct DirectoryUrl {
    static let directoryUrl = "mobile/interview/directory"
}

class DirectoryApiController {
    
    var baseApiUrl: String!
    var myDict: NSDictionary?
    var delegate: ApiControllerProtocol!
    
    init(delegate: ApiControllerProtocol) {
        self.delegate = delegate
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            self.myDict = NSDictionary(contentsOfFile: path)
        }
        
    }
    
    func getImageData(path: String, completionHandler: ((_ data: Data) -> Void)?) {
        let url = URL(string: path)
        let session =  URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: {data, response, error -> Void in
            DispatchQueue.main.async(execute: {
                if data != nil {
                    if let handler = completionHandler {
                        handler(data!)
                    }
                }
            })
        })
        
        task.resume()
    }
}
