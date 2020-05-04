//
//  AddBudgetViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 3/24/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

protocol AddBudgetViewControllerProtocol: class {
    func addBudget (budget: Budget)
}

class AddBudgetViewController: UIViewController {
                     
    
    @IBOutlet weak var budgetNameTextField: UITextField!
    
    @IBOutlet weak var budgetMoneyTextField: UITextField!
    @IBOutlet weak var budgetMoneySelectorSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var budgetPermissionSwitch: UISwitch!
    @IBOutlet weak var budgetAddedMoneySwitch: UISwitch!
       
    
    @IBOutlet weak var budgetCycleView: UIView!    
    @IBOutlet weak var budgetStartDateLabel: UILabel!
    @IBOutlet weak var budgetPeriodLabel: UILabel!
    @IBOutlet weak var budgetCycleButton: UIButton!
    @IBOutlet weak var budgetCycleLittleButton: UIButton!
    
    
    weak var delegate: AddBudgetViewControllerProtocol?
    
    var budget: Budget?
    
    var transaction = [Transaction]() 
    var permission = true
    var select : Int = 1000
    var addedMoney = true
    var cyclePeriod = ""
    var startDate = Date()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBudgetNavigationButton()   
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)        
        
        let font = UIFont.systemFont(ofSize: 14)
        budgetMoneySelectorSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        budgetCycleView.isHidden = true
        budgetCycleLittleButton.isHidden = true
        
        textField()
    }
    

        
    func textField() {
        budgetNameTextField.layer.borderWidth = 2
        budgetNameTextField.layer.borderColor = UIColor.yellow.cgColor
        budgetNameTextField.layer.cornerRadius = 3       
        
        budgetMoneyTextField.layer.borderWidth = 2
        budgetMoneyTextField.layer.borderColor = UIColor.yellow.cgColor
        budgetMoneyTextField.layer.cornerRadius = 3
    }
    
    func saveBudgetNavigationButton() {
        let addNavigationButton = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(addBudgetAction(sender:)))
        navigationItem.rightBarButtonItem = addNavigationButton
    }
    
    @objc func addBudgetAction(sender: UIBarButtonItem)   {
        var message = ""
        if let name = budgetNameTextField.text, name.count > 0, let money = budgetMoneyTextField.text, money.count > 0 {
            
            var money = Int(money) ?? 0
            money = money * select   
            if cyclePeriod.count > 0 {
                let budget = Budget(name: name, startMoney: money, money: money, addedMoney: addedMoney, permission: permission, period: cyclePeriod, startDate: startDate, comment: "")
                    delegate?.addBudget(budget: budget)
            } else {
                message = "Debe elegir una fecha y periodo para su ciclo"
            }
            } else {
                message = "Debe ingresar nombre y monto inicial"
            }
        if message != "" {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
        } else {}
        
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            select = 1000000
        } else {
            select = 1000
        }
    }
    
    @IBAction func statusPermissionSwitch(_ sender: Any) {
        if permission == true {
            permission = false
        } else {
            permission = true
        }
    }
    
    @IBAction func statusAddedMoneySwitch(_ sender: Any) {
        if addedMoney == true {
            addedMoney = false
        } else {
            addedMoney = true
        }        
    }  
    
    @objc func tapGestureHandler() {
          budgetNameTextField.endEditing(true)
          budgetMoneyTextField.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalVC" {
            let modalVC: ModalCycleViewController = segue.destination as! ModalCycleViewController
            modalVC.delegate = self
        }
        
        if segue.identifier == "reEnterModalVC" {
            let reEnterModalVC: ModalCycleViewController = segue.destination as! ModalCycleViewController
            reEnterModalVC.delegate = self
        }
    }   
    
}

extension AddBudgetViewController: ModalCycleViewControllerProtocol {
    func addCycle(period: String, date: Date) {
        cyclePeriod = period
        budgetPeriodLabel.text = cyclePeriod
        startDate = date
        budgetStartDateLabel.text = startDate.getFormatted(dateStyle: .short, timeStyle: .medium);
        budgetCycleView.isHidden = false
        budgetCycleButton.isHidden = true
        budgetCycleLittleButton.isHidden = false        
    }
    
}
        
