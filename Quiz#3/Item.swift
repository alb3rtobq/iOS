import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var identifier = NSUUID().uuidString
    @objc dynamic var tagNumber = 0
    @objc dynamic var name = ""
    @objc dynamic var purchaseDate = Date()
    @objc dynamic var quantity = 0       
    
    
    convenience init(tagNumber: Int, name: String, purchaseDate: Date(), quantity: Int){
        self.init()
        self.tagNumber = tagNumber
        self.name = name
        self.purchaseDate = purchaseDate
        self.quantity = quantity 
    }
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    override static func indexedProperties() -> [String] {
        return ["identifier"]
    }
    
}