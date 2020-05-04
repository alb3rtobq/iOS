//
//  TransactionTableViewCell.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/18/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var budgetTransactionNameLabel: UILabel!
    @IBOutlet weak var budgetTransactionMoneyLabel: UILabel!
    @IBOutlet weak var budgetIncomeTransactionView: UIImageView!
    @IBOutlet weak var budgetOutgoingTransactionView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(transaction: Transaction) {
    budgetTransactionNameLabel.text = transaction.name
    var money = String(transaction.money)
        if money.count > 3 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -3))
        }
        if money.count > 7 {
            money.insert(" ", at: money.index(money.endIndex, offsetBy: -7))
        }
    budgetTransactionMoneyLabel.text = "₡ " + money
        
    }
    
}

