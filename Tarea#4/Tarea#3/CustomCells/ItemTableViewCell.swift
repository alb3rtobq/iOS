//
//  ItemTableViewCell.swift
//  Tarea#3
//
//  Created by user169046 on 3/22/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!    
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!    
    @IBOutlet weak var inKartProductLabel: UILabel!
    
    func setupCell(item: Item) {
        
        itemImageView.image = UIImage(named: "product\(arc4random_uniform(5) + 1).png")
        nameLabel.text = item.name
        numberLabel.text = item.number
        unitsLabel.text = item.unit
        //priorityLabel.text = item.priority
        inKartProductLabel.isHidden = true
        
        let dateTime = item.date.getFormatted(dateStyle: .short, timeStyle: .none)
        dateLabel.text = dateTime + " - " + item.date.getFormatted(dateStyle: .none, timeStyle: .short) + " - "
        
        dateLabel.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 1, alpha: 1.0).cgColor
        dateLabel.layer.masksToBounds = true
        dateLabel.contentMode = .scaleToFill
        dateLabel.layer.borderWidth = 0.5
    }
    
}

	
