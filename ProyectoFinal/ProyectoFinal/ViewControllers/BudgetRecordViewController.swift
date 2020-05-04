//
//  RecordViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 3/24/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit
import RealmSwift

class BudgetRecordViewController: UIViewController {
    
   
    @IBOutlet weak var recordListTableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    var realmManager = RealmManager()
        
    var budgets: Results<Budget>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Volver", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        recordListTableView.backgroundView = UIImageView(image: UIImage(named: "BGRecord.jpg"))
        addBudgetNavigationButton()
        registerCustomCell()
        loadBudgetsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordListTableView.reloadData()
    }
    
    @objc func appMovedToForeground() {        
        recordListTableView.reloadData()
    }
    
    func registerCustomCell() {
        
        recordListTableView.register(UINib(resource: R.nib.transactionTableViewCell), forCellReuseIdentifier: R.nib.transactionTableViewCell.name)
        recordListTableView.register(UINib(resource: R.nib.budgetNameHeaderView), forHeaderFooterViewReuseIdentifier: R.nib.budgetNameHeaderView.name)
               
    }
    
    func addBudgetNavigationButton() {
        let addBudgetNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBudgetAction(sender:)))
        navigationItem.rightBarButtonItem = addBudgetNavigationButton
    }
    
    @objc func addBudgetAction(sender: UIBarButtonItem)   {
        if let addBudgetViewController = storyboard?.instantiateViewController(identifier: "AddBudgetViewController") as? AddBudgetViewController {
            addBudgetViewController.delegate = self
            navigationController?.pushViewController(addBudgetViewController, animated: true)
        }
    }
    func loadBudgetsList() {
            let realmManager = RealmManager()
            let budgets = realmManager.getAllBudgets()
        if let budgets = budgets, budgets.isEmpty {
              
            } else {
                self.budgets = budgets
                recordListTableView.reloadData()
            }
    }
    
    
    @IBAction func transactionsSortedByName(_ sender: Any) {
        budgets = budgets?.sorted(byKeyPath: "name", ascending: true)
        recordListTableView.reloadData()
    }
        
    
    @IBAction func transactionsSortedByMoney(_ sender: Any) {
        budgets = budgets?.sorted(byKeyPath: "money", ascending: false)
        recordListTableView.reloadData()        
    }
    
    @IBAction func transactionsSortedByDate(_ sender: Any) {
        budgets = budgets?.sorted(byKeyPath: "startDate", ascending: true)
        recordListTableView.reloadData()
    }
}

extension BudgetRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return budgets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets?[section].transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.transactionTableViewCell.name) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        if let transaction = budgets?[indexPath.section].transactions[indexPath.row] {
            cell.setupCell(transaction: transaction)            
        }
        
        if budgets?[indexPath.section].transactions[indexPath.row].type == true {
            cell.budgetIncomeTransactionView.isHidden = true
            cell.budgetOutgoingTransactionView.isHidden = false
        }
        else {
            cell.budgetIncomeTransactionView.isHidden = false
            cell.budgetOutgoingTransactionView.isHidden = true
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dateTransaction = budgets?[indexPath.section].transactions[indexPath.row].startDate
        let date = dateTransaction!.getFormatted(dateStyle: .short, timeStyle: .medium);
        let refreshAlert = UIAlertController(title: "Fecha de Transacción", message: date, preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
            tableView.reloadData()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let refreshAlert = UIAlertController(title: "Cambio en Coin 2 Coin", message: "Desea borrar Transaccion:  " + (budgets?[indexPath.section].transactions[indexPath.row].name)!, preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            if editingStyle == .delete {
                    let realmManager = RealmManager()
                    realmManager.deleteTransaction(identifier: (self.budgets?[indexPath.section].identifier)!, transactionID: (self.budgets?[indexPath.section].transactions[indexPath.row].identifier)!)
                self.recordListTableView.beginUpdates()
                self.recordListTableView.deleteRows(at: [indexPath], with: .fade)
                self.recordListTableView.endUpdates()
                self.recordListTableView.reloadData()
            }
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.budgetNameHeaderView.name) as? BudgetNameHeaderView else {
            return UIView()
        }
        if let budget = budgets?[section] {
            cell.setupCell(budget: budget)
        }        
        return cell
    }
    
}

extension BudgetRecordViewController: AddBudgetViewControllerProtocol {
    func addBudget(budget: Budget) {
        realmManager.addBudget(budget: budget)
        navigationController?.popViewController(animated: true)
        recordListTableView.reloadData()
    }
}
       
