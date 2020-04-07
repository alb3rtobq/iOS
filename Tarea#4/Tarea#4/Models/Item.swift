//
//  Item.swift
//  Tarea#3
//
//  Created by user169046 on 3/22/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation

import RealmSwift

class Item: Object {
    
    @objc dynamic var identifier =  NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var number = ""
    @objc dynamic var date = Date()
    @objc dynamic var unit = ""
    @objc dynamic var priority = ""
    @objc dynamic var inKartProduct = Bool()
    
    convenience init(name: String, number: String, unit: String, priority: String, inKartProduct: Bool) {
        self.init()
        self.name = name
        self.number = number
        self.date = Date()
        self.unit = unit
        self.priority = priority
        self.inKartProduct = inKartProduct
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
    
}
   


