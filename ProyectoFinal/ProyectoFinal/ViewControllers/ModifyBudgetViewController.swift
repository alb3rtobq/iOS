//
//  ModifyBudgetViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/16/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit
import RealmSwift

import MaterialComponents.MaterialButtons
//import MaterialComponents.MaterialButtons_Theming

protocol ModifyBudgetViewControllerProtocol: class {
    func addTransaction(money: Int, name: String, type: Bool)
}

class ModifyBudgetViewController: UIViewController {
    
    var budget: Budget?
    var type = Bool()
    
    @IBOutlet weak var budgetStartDateLabel: UILabel!
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetPeriodLabel: UILabel!
    @IBOutlet weak var budgetTotalMoneyLabel: UILabel!
    @IBOutlet weak var budgetDaysLabel: UILabel!
    @IBOutlet weak var budgetHoursLabel: UILabel!
    @IBOutlet weak var budgetColumnDaysStackView: UIStackView!
    @IBOutlet weak var budgetColumnHoursStackView: UIStackView!
    
    
    @IBOutlet weak var budgetOutgoingDetailTextField: UITextField!
    @IBOutlet weak var budgetOutgoingMoneyTextField: UITextField!        
    @IBOutlet weak var budgetIncomeDetailTextField: UITextField!
    @IBOutlet weak var budgetIncomeMoneyTextField: UITextField!
    @IBOutlet weak var addButtonsStackView: UIStackView!
    @IBOutlet weak var addOutgoingStackView: UIStackView!    
    @IBOutlet weak var addIncomeStackView: UIStackView!
    @IBOutlet weak var addBackButton: UIButton!
    @IBOutlet weak var budgetCommentLabel: UILabel!    
    @IBOutlet weak var noCommentImageView: UIImageView!
    @IBOutlet weak var fullCommentImageView: UIImageView!
    
    var endDate = Date()
    var modifiedDate = Date()
    var dayTime = DateComponents()
    var money = ""
    
    var realmManager = RealmManager()
    
    weak var delegate : ModifyBudgetViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()   
        
        budgetStartDateLabel.text = budget?.startDate.getFormatted(dateStyle: .short, timeStyle: .none);
        budgetNameLabel.text = budget?.name
        budgetPeriodLabel.text = budget?.period
        budgetCommentLabel.text = budget?.comment
        if budgetCommentLabel.text == "" {
            noCommentImageView.isHidden = false
            fullCommentImageView.isHidden = true
        }
        else {
            noCommentImageView.isHidden = true
            fullCommentImageView.isHidden = false
        }
        
        money = String(budget?.money ?? 0)
        if money.count > 3 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -3))
        }
        if money.count > 7 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -7))
        }
        budgetTotalMoneyLabel.text = "₡ " + money
        budgetTotalMoneyLabel.textDropShadow()
        
        addOutgoingStackView.isHidden = true
        addIncomeStackView.isHidden = true
        addBackButton.isHidden = true
        
        generateEndDate()
                
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ModifyBudgetViewController.updateCounter), userInfo: nil, repeats: true)        
    }
        
    @objc func updateCounter() {
        let currentDate = Date()
        if (currentDate.compare(endDate) == .orderedAscending) {
            dayTime = NSCalendar.current.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: endDate)
            budgetDaysLabel.text = "\(dayTime.day!)"
            budgetHoursLabel.text = "\(dayTime.hour!):\(dayTime.minute!):\(dayTime.second!)"
        }
        else {
            realmManager.modifyBudgetDate(identifier: budget!.identifier)
            money = String(budget?.money ?? 0)
            if money.count > 3 {
                money.insert(" ", at: money.index(money.endIndex, offsetBy: -3))
            }
            if money.count > 7 {
                money.insert(" ", at: money.index(money.endIndex, offsetBy: -7))
            }
            budgetTotalMoneyLabel.text = "₡ " + money
            generateEndDate()
        }
    }
    
    func generateEndDate() {
        endDate = Calendar.current.date(byAdding: .month, value: 1, to: budget!.startDate)!
        
        if budget?.period == "Semanal" {
            endDate = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: budget!.startDate)!
        }
        else { if budget?.period == "Quincenal" {
            endDate = Calendar.current.date(byAdding: .day, value: 15, to: budget!.startDate)!
            }
        }
    }

    @IBAction func addBudgetOutgoingAction(_ sender: Any) {
        addButtonsStackView.isHidden = true
        addOutgoingStackView.isHidden = false
        addBackButton.isHidden = false
        budgetOutgoingDetailTextField.text = ""
        budgetOutgoingMoneyTextField.text = ""
        budgetOutgoingDetailTextField.becomeFirstResponder()
    }
    
    @IBAction func addBugetOutgoingButton(_ sender: Any) {
        type = true
        let moneyStr = budgetOutgoingMoneyTextField.text ?? ""
        let name = budgetOutgoingDetailTextField.text ?? ""
        let money =  (Int(moneyStr)!) * -1
        
        var transaction = String(budget!.money + money)
        if transaction.count > 3 {
            transaction.insert(" ", at: transaction.index(transaction.endIndex, offsetBy: -3))
        }
        if transaction.count > 7 {
            transaction.insert(" ", at: transaction.index(transaction.endIndex, offsetBy: -7))
        }
        
        budgetTotalMoneyLabel.text = "₡ " + transaction
        delegate?.addTransaction(money: money, name: name, type: type)
        dismiss(animated: true, completion: nil)
        addButtonsStackView.isHidden = false
        addOutgoingStackView.isHidden = true
        addIncomeStackView.isHidden = true
        addBackButton.isHidden = true        
    }
    
    @IBAction func addBudgetIncomeAction(_ sender: Any) {
        addButtonsStackView.isHidden = true
        addIncomeStackView.isHidden = false
        addBackButton.isHidden = false
        budgetIncomeDetailTextField.text = ""
        budgetIncomeMoneyTextField.text = ""
        budgetIncomeDetailTextField.becomeFirstResponder()
    }
    
    @IBAction func addBudgetIncomeButton(_ sender: Any) {
        type = false
        let moneyStr = budgetIncomeMoneyTextField.text ?? ""
        let name = budgetIncomeDetailTextField.text ?? ""
        let money =  Int(moneyStr)!
        
        var transaction = String(budget!.money + money)
        if transaction.count > 3 {
            transaction.insert(" ", at: transaction.index(transaction.endIndex, offsetBy: -3))
        }
        if transaction.count > 7 {
            transaction.insert(" ", at: transaction.index(transaction.endIndex, offsetBy: -7))
        }

        budgetTotalMoneyLabel.text = "₡ " + transaction
        delegate?.addTransaction(money: money, name: name, type: type)
        dismiss(animated: true, completion: nil)
        addButtonsStackView.isHidden = false
        addOutgoingStackView.isHidden = true
        addIncomeStackView.isHidden = true
        addBackButton.isHidden = true
    }
    
    
    @IBAction func addBackButtonAction(_ sender: Any) {
        addButtonsStackView.isHidden = false
        addOutgoingStackView.isHidden = true
        addIncomeStackView.isHidden = true
        addBackButton.isHidden = true
    }
    
}

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}
