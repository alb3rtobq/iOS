//
//  Animal.swift
//  AsignacionAdicional
//
//  Created by user169046 on 4/7/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation
import RealmSwift

class Animal: Object {
    
    @objc dynamic var identifier =  NSUUID().uuidString
    @objc dynamic var petName = ""
    @objc dynamic var petType = ""
    @objc dynamic var ownerName = ""
    @objc dynamic var phone = ""
    @objc dynamic var location = ""
    @objc dynamic var likeIt = Bool()
    
    convenience init(petName: String, petType: String, ownerName: String, phone: String, location: String, likeIt: Bool) {
        self.init()
        self.petName = petName
        self.petType = petType
        self.ownerName = ownerName
        self.phone = phone
        self.location = location
        self.likeIt = likeIt
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
    
}
