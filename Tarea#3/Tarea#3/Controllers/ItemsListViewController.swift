//
//  ItemsListViewController.swift
//  Tarea#3
//
//  Created by user169046 on 3/22/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class ItemsListViewController: UIViewController {

    
    @IBOutlet weak var messageAddLabel: UIStackView!
    
    @IBOutlet weak var priorityMenuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var logoImageView: UIImageView!    
    
    @IBOutlet weak var showLogoImageButton: UIButton!
    @IBOutlet weak var hideLogoImageButton: UIButton!
    
    let itemTableViewCellIdentifier = "ItemTableViewCell"
    var items = [Item]()
    
        
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
       
        
        // Do any additional setup after loading the view.
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
        
        let refreshAlert = UIAlertController(title: "Vaciar carrito", message: "Todos los productos seran sacados...", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.items.removeAll()
            self.tableView.reloadData()
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    //1- Registrar la celda custom
    func registerCustomCell() {
        let nib = UINib(nibName: itemTableViewCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: itemTableViewCellIdentifier)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ItemsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        applyChanges()
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: itemTableViewCellIdentifier) as? ItemTableViewCell else {
        let cell = UITableViewCell()
        //cell.textLabel?.text = "NO EXISTE"
        return cell
        
    }
        cell.setupCell(item: items[indexPath.row])
        if items[indexPath.row].priority == "2" {
            cell.priorityLabel.backgroundColor = UIColor.yellow
        }
        else if items[indexPath.row].priority == "1" {
            cell.priorityLabel.backgroundColor = UIColor.green
        }
        else {
            cell.priorityLabel.backgroundColor = UIColor.red
        }       
        
        return cell
    }
    
    func applyChanges() {
        if items.count == 0 {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            items = items.sorted(by: { $0.priority > $1.priority })
            tableView.reloadData()
        } else {
            if sender.selectedSegmentIndex == 1 {
                items = items.sorted(by: { $0.date > $1.date })
                tableView.reloadData()
            } else {
                items = items.sorted(by: { $0.priority < $1.priority })
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
    
}

extension ItemsListViewController: AddItemViewControllerProtocol {
    func addItem(item: Item) {        
        items.append(item)
        navigationController?.popViewController(animated: true)
        items = items.sorted(by: { $0.date > $1.date })
        tableView.reloadData()
    }
}


