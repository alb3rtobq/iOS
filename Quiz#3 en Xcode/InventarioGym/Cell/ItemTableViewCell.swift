//
//  ItemTableViewCell.swift
//  InventarioGym
//
//  Created by user169046 on 4/5/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var tagNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    func setupCell(item: Item) {
        tagNumberLabel.text = "tag#:  " + String(item.tagNumber)
        nameLabel.text = "Nombre:  " + item.name
        quantityLabel.text = "Cantidad:  " + String(item.quantity)
        purchaseDateLabel.text = "Fecha compra:  " + item.purchaseDate.getFormatted(dateStyle: .short, timeStyle: .none)
    }
    
}

extension Date {
    
    func getFormatted(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        let localizedDate = formatter.string(from: self)
        return localizedDate
    }
    
}
