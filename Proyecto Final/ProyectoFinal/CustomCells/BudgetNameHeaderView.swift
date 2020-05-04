//
//  BudgetNameHeaderView.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/18/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class BudgetNameHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetStartMoneyLabel: UILabel!
    @IBOutlet weak var budgetMoneyLabel: UILabel!
    @IBOutlet weak var showBudgetStartMoneyButton: UIButton!
    @IBOutlet weak var hideBudgetStartMoneyButton: UIButton!
    @IBOutlet weak var budgetStartMoneyView: UIView!   
    @IBOutlet weak var budgetMoneyView: UIView!
    
    func setupCell(budget: Budget) {
        var startMoney = String(budget.startMoney)
        if startMoney.count > 3 {
            startMoney.insert(" ", at: startMoney.index(startMoney.endIndex, offsetBy: -3))
        }
        if startMoney.count > 7 {
            startMoney.insert(" ", at: startMoney.index(startMoney.endIndex, offsetBy: -7))
        }
        
        var money = String(budget.money)
        if money.count > 3 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -3))
        }
        if money.count > 7 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -7))
        }
                
        budgetNameLabel.text = budget.name
        budgetStartMoneyLabel.text = "₡ " + startMoney
        budgetMoneyLabel.text = "₡ " + money
        budgetStartMoneyView.isHidden = true
    }
    
    
    @IBAction func showBudgetStartMoneyAction(_ sender: Any) {
        budgetStartMoneyView.isHidden = false
        budgetMoneyView.isHidden = true
    }
    
    @IBAction func hideBudgetStartMoneyAction(_ sender: Any) {
        budgetStartMoneyView.isHidden = true
        budgetMoneyView.isHidden = false
    }
    
}
