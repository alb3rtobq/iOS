//
//  BudgetListViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 3/24/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit
import RealmSwift

class BudgetListViewController: UIViewController {
    //, UITabBarControllerDelegate
    @IBOutlet weak var budgetListTableView: UITableView!
    @IBOutlet weak var sortByDateButton: UIButton!
    @IBOutlet weak var displayHelpButton: UIButton!
    
    let budgetTableViewCellIdentifier = "BudgetTableViewCell"
        
    var moneyTransaction = ""
    var detailTransaction = ""
    var budgetId = ""
    var budgetIndex = Int()
    var budgetNameIndexToEdit: Int?
    var password = "123"
    
    var realmManager = RealmManager()
        
    var budgets: Results<Budget>?
    
    var user = String()
    var pass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cesar"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Volver", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)        
        
        budgetListTableView.tableFooterView = UIView(frame: .zero)
        budgetListTableView.backgroundView = UIImageView(image: UIImage(named: "fondoLista.jpg"))
        self.budgetListTableView.backgroundColor = UIColor(red: 0.5412, green: 0.5569, blue: 0.6275, alpha: 1.0)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(BudgetListViewController.showHelpIcon), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(BudgetListViewController.hideHelpIcon), userInfo: nil, repeats: true)
        
        self.budgetListTableView.sectionIndexColor = UIColor(red: 1, green: 0.902, blue: 0.5098, alpha: 1.0)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        registerCustomCell()
        addBudgetNavigationButton()
        logoutNavigationButton()
        loadBudgetsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        budgetListTableView.reloadData()
    }
    
    @objc func appMovedToForeground() {        
        budgetListTableView.reloadData()
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
    
    func logoutNavigationButton() {
        let logoutNavigationButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deleteAction(sender:)))
        navigationItem.leftBarButtonItem = logoutNavigationButton
    }
    
    @objc func deleteAction(sender: UIBarButtonItem)   {
        UserDefaults.standard.set(false, forKey: "status")
        UserStatusAction.updateRootVC()
    }
    
    func registerCustomCell() {
        let nib = UINib(nibName: budgetTableViewCellIdentifier, bundle: nil)
        budgetListTableView.register(nib, forCellReuseIdentifier: budgetTableViewCellIdentifier)
    }
    
    func loadBudgetsList() {
            let realmManager = RealmManager()
            let budgets = realmManager.getAllBudgets()
        if let budgets = budgets, budgets.isEmpty {
              
            } else {
            self.budgets = budgets
                budgetListTableView.reloadData()
            }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editBudgetName" {
            let editBudgetName: EditBudgetNameViewController = segue.destination as! EditBudgetNameViewController  
            editBudgetName.delegate = self
        }
    }
    
    @objc func showHelpIcon() {
        displayHelpButton.isHidden = false
    }
    
    @objc func hideHelpIcon() {
        displayHelpButton.isHidden = true
    }
    
    func passwordForPermissionError() {
        let alertController = UIAlertController(
            title: "Cambio de seguridad en presupuesto",
            message: "Contraseña incorrecta",
            preferredStyle: .alert)
        
        let loginAction = UIAlertAction(
        title: "Aceptar", style: .default) {
            (action) -> Void in
            
        }
        
        alertController.addAction(loginAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func displayHelpAction(_ sender: Any) {
        let displayBudgetHelp = self.storyboard?.instantiateViewController(withIdentifier: "BudgetHelpViewController") as! BudgetHelpViewController
        self.navigationController?.pushViewController(displayBudgetHelp, animated: true)
    }
    
    @IBAction func budgetSortedByName(_ sender: Any) {
        budgets = budgets?.sorted(byKeyPath: "name", ascending: true)
        budgetListTableView.reloadData()
    }
    
    @IBAction func budgetSortedByMoney(_ sender: Any) {
        budgets = budgets?.sorted(byKeyPath: "money", ascending: false)
        budgetListTableView.reloadData()
    }
    
    @IBAction func budgetSortedByDate(_ sender: Any) {
        budgets = budgets?.sorted(byKeyPath: "startDate", ascending: true)
        budgetListTableView.reloadData()
    }
    
}

extension BudgetListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: budgetTableViewCellIdentifier) as? BudgetTableViewCell else {
            let cell = UITableViewCell()
            return cell
       }
        
        if let budget = budgets?[indexPath.row] {
            cell.setupCell(budget: budget)
        }
        
        if budgets?[indexPath.row].money ?? 0 > 0 {
            cell.upColorLineView.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1.0)
            cell.downColorLineView.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 1, alpha: 1.0)
        }
        else {
            cell.upColorLineView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
            cell.downColorLineView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        }
        
        if budgets?[indexPath.row].permission == true {
            cell.budgetPermissionButton.isHidden = false
            cell.budgetNoPermissionButton.isHidden = true
        }
        else {
            cell.budgetPermissionButton.isHidden = true
            cell.budgetNoPermissionButton.isHidden = false
        }
        
        if budgets?[indexPath.row].addedMoney == true {
            cell.budgetAddedMoneyButton.isHidden = false
            cell.budgetNoAddedMoneyButton.isHidden = true
        }
        else {
            cell.budgetAddedMoneyButton.isHidden = true
            cell.budgetNoAddedMoneyButton.isHidden = false
        }
        cell.cellDelegate = self
        cell.index = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        
        if let modifyBudgetViewController = storyboard?.instantiateViewController(identifier: "ModifyBudgetViewController") as? ModifyBudgetViewController {
            modifyBudgetViewController.budget = budgets?[indexPath.row]
            budgetIndex = indexPath.row
            modifyBudgetViewController.delegate = self
            navigationController?.pushViewController(modifyBudgetViewController, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Editar") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.budgetNameIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "editBudgetName", sender: nil)
            actionPerformed(true)
        }
        
        edit.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexPath) in
        let refreshAlert = UIAlertController(title: "Cambio en Coin 2 Coin", message: "Desea borrar Presupuesto:  " + (self.budgets?[indexPath.row].name)!, preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in            
                let realmManager = RealmManager()
                realmManager.deleteBudget(identifier: (self.budgets?[indexPath.row].identifier)!)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    return [delete]
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}

extension BudgetListViewController: AddBudgetViewControllerProtocol {
    func addBudget(budget: Budget) {
        realmManager.addBudget(budget: budget)        
        navigationController?.popViewController(animated: true)
        budgetListTableView.reloadData()        
    }
}

extension BudgetListViewController: ModifyBudgetViewControllerProtocol {
    func addTransaction(money: Int, name: String, type: Bool) {
        realmManager.modifyBudgetMoney(identifier: (self.budgets?[budgetIndex].identifier)!, money: money, name: name, type: type, startDate: Date())
        budgetListTableView.reloadData()
    }
}

extension BudgetListViewController: BudgetTableViewCellDelegate {
    func AddedMoney(status: Bool, index: Int) {
        realmManager.modifyBudgetAddedMoney(status: status, identifier: (self.budgets?[index].identifier)!)
        budgetListTableView.reloadData()
    }
    
    func Permission(status: Bool, index: Int) {
        
        var passwordTextField: UITextField?
        
        let alertController = UIAlertController(
            title: "Cambio de seguridad en presupuesto",
            message: "Introduzca su contraseña",
            preferredStyle: .alert)
        
        let loginAction = UIAlertAction(
        title: "Autorizar", style: .default) {
            (action) -> Void in
            
            if let pwd = passwordTextField?.text {
                if pwd == self.password {
                    self.realmManager.modifyBudgetPermission(status: status, identifier: (self.budgets?[index].identifier)!)
                    self.budgetListTableView.reloadData()
                }
                else { self.passwordForPermissionError() }
            } else {
                //print("No password entered")
            }
        }

        alertController.addTextField {
            (txtPassword) -> Void in
            passwordTextField = txtPassword
            passwordTextField?.isSecureTextEntry = true
            passwordTextField?.placeholder = "..."
        }
        
        alertController.addAction(loginAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension BudgetListViewController: EditBudgetNameViewControllerProtocol {
    func editName(name: String, comment: String) {
        realmManager.editBudgetName(name: name, comment: comment, identifier: (self.budgets?[budgetNameIndexToEdit!].identifier)!)
        budgetListTableView.reloadData()        
    }    
    
}
