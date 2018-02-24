//
//  DirectoryMapper.swift
//  Homework
//
//  Created by Stacy Chang on 2/24/18.
//  Copyright © 2018 Stacy Chang. All rights reserved.
//

import Foundation
import ObjectMapper

class DirectoryMap: Mappable {
    var individuals: [IndividualMap]?
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        individuals <- map["individuals"]
    }
}

class IndividualMap: Mappable {
    var id: Int16?
    var firstName: String?
    var lastName: String?
    var birthdate: String?
    var profileUrl: String?
    var forceSensitive: Bool?
    var affiliation: String?
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        birthdate <- map["birthdate"]
        profileUrl <- map["profilePicture"]
        forceSensitive <- map["forceSensitive"]
        affiliation <- map["affiliation"]
    }
}
