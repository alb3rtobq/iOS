//
//  RealmManager.swift
//  Tarea#4
//
//  Created by user169046 on 4/7/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation

import RealmSwift

class RealmManager {
    
    func addItem(item: Item) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: .all)
            }
        } catch {
            print("...")
        }
    }
    
    func modifyItem(identifier: String, statusProduct: Bool) {

        do {
            let realm = try Realm()

            let item = realm.objects(Item.self).filter("identifier = %@", identifier).first
            try! realm.write {
                item?.inKartProduct = statusProduct
                if let modifiedItem = item {
                    realm.add(modifiedItem, update: .modified)
                }
            }
            } catch {
                print("error")
        }
    }
    
    func getAllItems() -> Results<Item>? {
        let realm = try? Realm()
        return realm?.objects(Item.self)
    }
       
    func getAllItems(completionHandler:(_ items: Results<Item>?) -> Void) {
        completionHandler(getAllItems())
    }
    
    func deleteAllItems() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("...")
        }
    }
    
    func deleteItem(identifier: String) {

        do {
            let realm = try Realm()

            let item = realm.objects(Item.self).filter("identifier = %@", identifier).first

            try! realm.write {
                if let deleteItem = item {
                    realm.delete(deleteItem)
                }
            }
            } catch {
                print("error")
        }
    }
}

