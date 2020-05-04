//
//  RealmManager.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/19/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation
import RealmSwift


class RealmManager {
    
    func addBudget(budget: Budget) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(budget, update: .all)
            }
        } catch {
            print("...")
        }
    }
    
    func modifyBudgetMoney(identifier: String, money: Int, name: String, type: Bool, startDate: Date) {

        do {            
            let transaction = Transaction(name: name, money: abs(money), type: type, startDate: startDate)
            let realm = try Realm()
            
            let budget = realm.objects(Budget.self).filter("identifier = %@", identifier).first
            try! realm.write {
                budget?.money = budget!.money + money
                budget?.transactions.append(transaction)
                if let modifiedBudget = budget {
                    realm.add(modifiedBudget, update: .modified)
                }
            }
            } catch {
                print("error")
        }
    }
    
    func modifyBudgetDate(identifier: String) {

        do {
            let realm = try Realm()            
            let budget = realm.objects(Budget.self).filter("identifier = %@", identifier).first
            try! realm.write {
                budget?.startDate = Date()
                let actualMoney = budget?.money
                if budget?.addedMoney == true {
                    budget?.startMoney = actualMoney!
                }
                else {
                    budget?.startMoney = 0
                    budget?.money = 0
                }
                if let modifiedBudget = budget {
                    realm.add(modifiedBudget, update: .modified)
                }
            }
            } catch {
                print("error")
        }
    }
    
    func modifyBudgetAddedMoney(status: Bool, identifier: String) {

        do {
            let realm = try Realm()
            let budget = realm.objects(Budget.self).filter("identifier = %@", identifier).first
            try! realm.write {
                if status == true {
                    budget?.addedMoney = false                    
                }
                else {
                    budget?.addedMoney = true
                }
            }
            } catch {
                print("error")
        }
    }
    
    func modifyBudgetPermission(status: Bool, identifier: String) {

        do {
            let realm = try Realm()
            let budget = realm.objects(Budget.self).filter("identifier = %@", identifier).first
            try! realm.write {                
                if status == true {
                    budget?.permission = false
                }
                else {
                    budget?.permission = true
                }
            }
            } catch {
                print("error")
        }
    }
    
    func editBudgetName(name: String, comment: String, identifier: String) {

        do {
            let realm = try Realm()
            let budget = realm.objects(Budget.self).filter("identifier = %@", identifier).first
            try! realm.write {
                budget?.name = name
                budget?.comment = comment
                if let modifiedBudget = budget {
                    realm.add(modifiedBudget, update: .modified)
                }
            }
            } catch {
                print("error")
        }
    }
    
    func getAllBudgets() -> Results<Budget>? {
        let realm = try? Realm()
        return realm?.objects(Budget.self)
    }
       
    func getAllBudgets(completionHandler:(_ budgets: Results<Budget>?) -> Void) {
        completionHandler(getAllBudgets())
    }
    
    func deleteAllBudgets() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("...")
        }
        
    }
    
    func deleteBudget(identifier: String) {

        do {
            let realm = try Realm()

            let budget = realm.objects(Budget.self).filter("identifier = %@", identifier).first

            try! realm.write {
                if let deleteBudget = budget {
                    realm.delete(deleteBudget)
                }
            }
            } catch {
                print("error")
        }
    }
    
    func deleteTransaction(identifier: String, transactionID: String) {

        do {
            
            let realm = try Realm()
            
            let budget = realm.objects(Budget.self).filter("identifier = %@", identifier).first
            if let index = budget?.transactions.firstIndex(where: { $0.identifier == transactionID }) {
                try! realm.write {
                    if let modifiedBudget = budget {
                        modifiedBudget.money = modifiedBudget.money + modifiedBudget.transactions[index].money
                        modifiedBudget.transactions.remove(at: index)
                    }
                }
            }
            } catch {
                print("error")
        }
    }
}


