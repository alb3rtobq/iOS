//
//  Budget.swift
//  ProyectoFinal
//
//  Created by user169046 on 3/24/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation
import RealmSwift

class Budget: Object {
    
    @objc dynamic var identifier =  NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var startMoney = 0
    @objc dynamic var money = 0
    @objc dynamic var addedMoney = Bool()
    @objc dynamic var permission = Bool()
    @objc dynamic var period = ""
    @objc dynamic var startDate = Date()
    @objc dynamic var comment =  ""
    
    var transactions = List<Transaction>()
    
    convenience init(name: String, startMoney: Int, money: Int, addedMoney: Bool, permission: Bool, period: String, startDate: Date, comment: String) {
        self.init()
        self.name = name
        self.startMoney = startMoney
        self.money = money
        self.addedMoney = addedMoney
        self.permission = permission
        self.period = period
        self.startDate = Date()
        self.comment = comment
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }

}
          
        
        
        
   
