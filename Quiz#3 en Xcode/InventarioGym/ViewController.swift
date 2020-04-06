//
//  ViewController.swift
//  InventarioGym
//
//  Created by user169046 on 4/4/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let itemTableViewCellID = "ItemTableViewCell"
    var items: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        createList()       
        
    }
        
    func registerCell() {
        let nib = UINib(nibName: itemTableViewCellID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: itemTableViewCellID)
    }
        
    func createList() {
            let realmManager = RealmManager()
            let items = realmManager.getAllItems()
            if let items = items, items.isEmpty {
                realmManager.insertItem(tagNumber: 000, name: "Pesa", quantity: 10)
                realmManager.insertItem(tagNumber: 001, name: "Barra", quantity: 20)
                realmManager.insertItem(tagNumber: 002, name: "Cuerda", quantity: 5)
                realmManager.insertItem(tagNumber: 003, name: "Tapete", quantity: 50)
                realmManager.insertItem(tagNumber: 004, name: "Toalla", quantity: 25)
                realmManager.insertItem(tagNumber: 005, name: "Botella", quantity: 100)
                realmManager.insertItem(tagNumber: 006, name: "Guante", quantity: 30)
                realmManager.insertItem(tagNumber: 007, name: "Gorra", quantity: 15)
                realmManager.insertItem(tagNumber: 008, name: "Calceta", quantity: 40)
                realmManager.insertItem(tagNumber: 009, name: "Munequera", quantity: 35)
                createList()
            } else {
                self.items = items
                tableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: itemTableViewCellID) as? ItemTableViewCell else {
            let cell = UITableViewCell()
            return cell
        }
        
        if let item = items?[indexPath.row] {
            cell.setupCell(item: item)
        }
        return cell
    }
    
    
}

