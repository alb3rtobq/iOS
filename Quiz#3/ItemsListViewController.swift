import UIKit
import RealmSwift

class ItemsListViewController: UIViewController {
    @IBOutlet weak var itemsListtableView: UITableView!
    
    let itemTableViewCellIdentifier = "ItemTableViewCell"
    var items: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemsListtableView.dataSource = self
        itemsListtableView.delegate = self

        registerCustomCell()
        createList()
    }
       
    func registerCustomCell() {
        let nib = UINib(nibName: itemTableViewCellIdentifier, bundle: nil)
        itemsListtableView.register(nib, forCellReuseIdentifier: itemTableViewCellIdentifier)
    }
    
    func createList() {
        let realmManager = RealmManager()
        let items = realmManager.getAllCategories()
        if let items = items, items.isEmpty {
            realmManager.insertItem(tagNumber: "11", name: "Pesa 1kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "22", name: "Pesa 2kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "33", name: "Pesa 3kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "44", name: "Pesa 4kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "55", name: "Pesa 5kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "66", name: "Pesa 6kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "77", name: "Pesa 7kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "88", name: "Pesa 8kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "99", name: "Pesa 9kg", purchaseDate: "1/1/2020", quantity: "10")
            realmManager.insertItem(tagNumber: "00", name: "Pesa 10kg", purchaseDate: "1/1/2020", quantity: "10")
                        
            createList()
        } else {
            self.items = items
            itemsListtableView.reloadData()
        }
    }
}

extension ItemsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = itemListtableView.dequeueReusableCell(withIdentifier: itemTableViewCellIdentifier)  as? ItemTableViewCell else {
            let cell = UITableViewCell()
            
            return cell
        }
        if let item = items?[indexPath.row] {
            cell.setupCell(item: item)
        }
        return cell
    }
          
    
}