//
//  RealmManager.swift
//  AsignacionAdicional
//
//  Created by user169046 on 4/7/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation

import RealmSwift

class RealmManager {
    
    func addAnimal(animal: Animal) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(animal, update: .all)
            }
        } catch {
            print("...")
        }
    }
    
    func modifyAnimal(identifier: String, statusLikeIt: Bool) {

        do {
            let realm = try Realm()

            let animal = realm.objects(Animal.self).filter("identifier = %@", identifier).first
            try! realm.write {
                animal?.likeIt = statusLikeIt
                if let modifiedAnimal = animal {
                    realm.add(modifiedAnimal, update: .modified)
                }
            }
            } catch {
                print("error")
        }
    }
    
    func getAllAnimals() -> Results<Animal>? {
        let realm = try? Realm()
        return realm?.objects(Animal.self)
    }
       
    func getAllAnimals(completionHandler:(_ items: Results<Animal>?) -> Void) {
        completionHandler(getAllAnimals())
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
    
    func deleteAnimal(identifier: String) {

        do {
            let realm = try Realm()

            let animal = realm.objects(Animal.self).filter("identifier = %@", identifier).first

            try! realm.write {
                if let deleteAnimal = animal {
                    realm.delete(deleteAnimal)
                }
            }
            } catch {
                print("error")
        }
    }
}


