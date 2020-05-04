//
//  Transaction.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/18/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation
import RealmSwift


class Transaction: Object {
    @objc dynamic var identifier =  NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var money = 0
    @objc dynamic var type = Bool()
    @objc dynamic var startDate = Date()
    
    let budgets = LinkingObjects(fromType: Budget.self, property: "transactions")

    convenience init(name: String, money: Int, type: Bool, startDate: Date) {
        self.init()
        self.name = name
        self.money = money
        self.type = type
        self.startDate = Date()
    }
    
}
