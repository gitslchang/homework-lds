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
    var api: DictionaryApiController?
    
    init(delegate: DictionaryDataProviderDelegate) {
        self.delegate = delegate

    }
    
    func getSentientBeings() {
        api = DictionaryApiController(delegate: self)
        
    }
    
    
    // MARK: ApiControllerProtocol
    func didReceiveError() {
        print("error")
    }
    
    func didReceiveResults() {
        print("wahoo")
        delegate.updateDictionaryData()
    }
}
