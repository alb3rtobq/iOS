//
//  BudgetTableViewCell.swift
//  ProyectoFinal
//
//  Created by user169046 on 3/25/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

protocol BudgetTableViewCellDelegate: class {
    func AddedMoney (status: Bool, index: Int)
    func Permission (status: Bool, index: Int)
    
}

class BudgetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetMoneyLabel: UILabel!
    @IBOutlet weak var budgetAddedMoneyButton: UIButton!
    @IBOutlet weak var budgetNoAddedMoneyButton: UIButton!
    @IBOutlet weak var budgetPermissionButton: UIButton!
    @IBOutlet weak var budgetNoPermissionButton: UIButton!
    @IBOutlet weak var upColorLineView: UIView!
    @IBOutlet weak var downColorLineView: UIView!    
    @IBOutlet weak var budgetCommentImageView: UIImageView!
    
    var status = Bool()
    var cellDelegate: BudgetTableViewCellDelegate?
    var index: IndexPath?
    
    func setupCell(budget: Budget) {
        budgetNameLabel.text = budget.name
        var money = String(budget.money)
        if money.count > 3 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -3))
        }
        if money.count > 7 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -7))
        }
        
        budgetMoneyLabel.text = "₡ " + money
        if budget.comment == "" {
            budgetCommentImageView.isHidden = true
        }
        else {
            budgetCommentImageView.isHidden = false
        }
        
        }
            
        
    
    @IBAction func budgetPermissionAction(_ sender: Any) {
        status = true
        cellDelegate?.Permission(status: status, index: (index?.row)!)
    }
    
    @IBAction func budgetNoPermissionAction(_ sender: Any) {
        status = false
        cellDelegate?.Permission(status: status, index: (index?.row)!)
    }
    
    @IBAction func budgetAddedMoneyAction(_ sender: Any) {
        status = true
        cellDelegate?.AddedMoney(status: status, index: (index?.row)!)
    }
    
    @IBAction func budgetNoAddedMoneyAction(_ sender: Any) {
        status = false
        cellDelegate?.AddedMoney(status: status, index: (index?.row)!)
    }
}


