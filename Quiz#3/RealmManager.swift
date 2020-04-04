import Foundation
import RealmSwift

class RealmManager {
    
    func insertItem(tagNumber: Int, name: String, purchaseDate: Date(), quantity: Int) {
        let item = Item(tagNumber: tagNumber, name: name, purchaseDate: purchaseDate(), quantity: quantity)
        do {            
            let realm = try Realm()
            try realm.write {
                realm.add(item, update: .all)
            }
        } catch {
            
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