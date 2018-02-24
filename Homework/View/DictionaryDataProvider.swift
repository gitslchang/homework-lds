//
//  DictionaryDataProvider.swift
//  Homework
//
//  Created by Stacy Chang on 2/23/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import Foundation

protocol DictionaryDataProviderDelegate {
    func updateDictionaryData()
}

class DictionaryDataProvider: NSObject, ApiControllerProtocol {
    
    var delegate: DictionaryDataProviderDelegate!
    var api: DirectoryApiController?
    
    init(delegate: DictionaryDataProviderDelegate) {
        self.delegate = delegate

    }
    
    func getSentientBeingsFromApi() {
        api = DirectoryApiController(delegate: self)
        api?.getDirectoryIndividuals(completionHandler: nil)
    }
    
    func queryDirectory() -> [SentientBeing] {
        api = DirectoryApiController(delegate: self)
        if let beings = api?.fetchSentientBeingsFromLocalStore() {
            return beings 
        }
        return [SentientBeing]()
    }
    
    
    // MARK: ApiControllerProtocol
    func didReceiveError(statusCode: Int, error: String) {
        print(error)
    }
    
    func didReceiveResults() {
        print("wahoo")
        delegate.updateDictionaryData()
    }
}
