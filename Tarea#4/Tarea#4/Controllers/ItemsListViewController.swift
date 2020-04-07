//
//  ItemsListViewController.swift
//  Tarea#4
//
//  Created by user169046 on 3/22/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

import RealmSwift

class ItemsListViewController: UIViewController {

    
    @IBOutlet weak var messageAddLabel: UIStackView!
    
    @IBOutlet weak var priorityMenuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var showLogoImageButton: UIButton!
    @IBOutlet weak var hideLogoImageButton: UIButton!
    
    var realmManager = RealmManager()
    let itemTableViewCellIdentifier = "ItemTableViewCell"
    
    var items: Results<Item>?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Super Shopper"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Volver", style: .plain, target: nil, action: nil)
        
        tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.backgroundColor = UIColor(red: 0.89145, green: 0.93, blue: 1, alpha: 1.0)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addItemLogoButton(tapGestureRecognizer:)))
        logoImageView.isUserInteractionEnabled = true
        logoImageView.addGestureRecognizer(tapGestureRecognizer)
        
        showLogoImageButton.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        registerCustomCell()
        deleteNavigationButton()
        addItemNavigationButton()
        
        loadItemsList()
             
       
    }
    
    @objc func addItemLogoButton(tapGestureRecognizer: UITapGestureRecognizer) {
        if let addItemViewController = storyboard?.instantiateViewController(identifier: "AddItemViewController") as? AddItemViewController {
            addItemViewController.delegate = self
            navigationController?.pushViewController(addItemViewController, animated: true)
        }
    }
    
    func addItemNavigationButton() {
        let addItemNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemAction(sender:)))
        navigationItem.rightBarButtonItem = addItemNavigationButton
    }
    
    @objc func addItemAction(sender: UIBarButtonItem)   {
        if let addItemViewController = storyboard?.instantiateViewController(identifier: "AddItemViewController") as? AddItemViewController {
            addItemViewController.delegate = self
            navigationController?.pushViewController(addItemViewController, animated: true)
        }
    }
    
    func deleteNavigationButton() {
        let deleteNavigationButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction(sender:)))
        navigationItem.leftBarButtonItem = deleteNavigationButton
    }
    
    @objc func deleteAction(sender: UIBarButtonItem)   {
        
        let refreshAlert = UIAlertController(title: "Vaciar carrito", message: "Todos los productos serán sacados...", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            let realmManager = RealmManager()
            realmManager.deleteAllItems()
            self.tableView.reloadData()
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func registerCustomCell() {
        let nib = UINib(nibName: itemTableViewCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: itemTableViewCellIdentifier)
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            //items = items.sorted(by: { $1.inKartProduct } )
            tableView.reloadData()
        } else {
            if sender.selectedSegmentIndex == 1 {
                items = items?.sorted(byKeyPath: "date", ascending: false)
                tableView.reloadData()
            } else {
                items = items?.sorted(byKeyPath: "priority", ascending: false)
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func showLogoButton( sender: UIButton ) {
        logoImageView.isHidden = false
        hideLogoImageButton.isHidden = false
        showLogoImageButton.isHidden = true
    }
    
    @IBAction func hideLogoButton( sender: UIButton ) {
        logoImageView.isHidden = true
        showLogoImageButton.isHidden = false
        hideLogoImageButton.isHidden = true
    }
    
    func applyChanges() {
        if items?.count == 0 {
            messageAddLabel.isHidden = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            priorityMenuSegmentedControl.isEnabled = false
            showLogoButton(sender: showLogoImageButton)
        }
        else {
            messageAddLabel.isHidden = true
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            priorityMenuSegmentedControl.isEnabled = true
        }
    }
           
    
    func loadItemsList() {
            let realmManager = RealmManager()
            let items = realmManager.getAllItems()
            if let items = items, items.isEmpty {
              
            } else {
                self.items = items
                tableView.reloadData()
            }
    }
}


extension ItemsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        applyChanges()
        return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: itemTableViewCellIdentifier) as? ItemTableViewCell else {
                let cell = UITableViewCell()
        return cell
            }

       if let item = items?[indexPath.row] {
            cell.setupCell(item: item)
        }
        if items?[indexPath.row].priority == "2" {
            cell.priorityLabel.backgroundColor = UIColor.yellow
        }
        else if items?[indexPath.row].priority == "1" {
            cell.priorityLabel.backgroundColor = UIColor.green
        }
        else {
            cell.priorityLabel.backgroundColor = UIColor.red
        }
        
        if items?[indexPath.row].inKartProduct == true {
            cell.inKartProductLabel.isHidden = false
        }
        else {
            cell.inKartProductLabel.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realmManager = RealmManager()           
            realmManager.deleteItem(identifier: (items?[indexPath.row].identifier)!)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var messageProduct = ""
        var statusProduct = true
        if items?[indexPath.row].inKartProduct == true {
            messageProduct = "Producto fuera del carrito"
            statusProduct = false
        } else {
            messageProduct = "Producto dentro del carrito"
            statusProduct = true
        }
        
        let refreshAlert = UIAlertController(title: "Cambio en carrito", message: messageProduct, preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            let realmManager = RealmManager()
            realmManager.modifyItem(identifier: (self.items?[indexPath.row].identifier)!, statusProduct: statusProduct) //self.items?[indexPath.row].inKartProduct = statusProduct
            
            self.priorityMenuSegmentedControl.setEnabled(false, forSegmentAt: 0)
                        
            //for n in items? {
              //  if self.items?[i].inKartProduct == true && !self.priorityMenuSegmentedControl.isEnabledForSegment(at: 0) { //self.priorityMenuSegmentedControl.setEnabled(true, forSegmentAt: 0) }
                //else {
                //}
            //}
            
            //Este for o una logica similar debe recorrer items para conocer si algun item tiene valor de true en propiedad inKartProduct.  Esto para hacer funcionar el boton Select de "Carrito" para ordenar la lista segun los productos Comprados.  Si se hace click sobre el item se agrega al carrito o se saca del carrito
            
            tableView.reloadData()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
}


extension ItemsListViewController: AddItemViewControllerProtocol {
    func addItem(item: Item) {
            realmManager.addItem(item: item)
            navigationController?.popViewController(animated: true)
            items = items?.sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
    }
}




