//
//  RealmManager.swift
//  InventarioGym
//
//  Created by user169046 on 4/4/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    
    
    func insertItem(tagNumber: Int, name: String, quantity: Int) {
        let item = Item(tagNumber: tagNumber, name: name, quantity: quantity)
        do {
            //let realm = try! Realm() esto es incorrecto xq esta haciendo un forze unwrap, si por alguna razon es nulo, la aplicación se va a caer
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: .all)
            }
        } catch {
            print("Realm falló por alguna razón")
        }
    }
    
    func getAllItems() -> Results<Item>? {
        let realm = try? Realm()
        return realm?.objects(Item.self)
    }
    
    func getAllItems(completionHandler:(_ items: Results<Item>?) -> Void) {
        completionHandler(getAllItems())
    }
}
