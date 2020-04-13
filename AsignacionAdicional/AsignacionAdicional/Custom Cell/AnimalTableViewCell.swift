//
//  AnimalTableViewCell.swift
//  AsignacionAdicional
//
//  Created by user169046 on 4/7/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var dogLikeImageView: UIImageView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catLikeImageView: UIImageView!    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!       
    
        
    func setupCell(animal: Animal) {
        dogImageView.image = UIImage(named: "perro.png")
        catImageView.image = UIImage(named: "gato.png")
        petNameLabel.text = animal.petName
        ownerNameLabel.text = animal.ownerName
        phoneLabel.text = animal.phone
        locationLabel.text = animal.location
        
        
        petNameLabel.backgroundColor = UIColor(patternImage: UIImage(named: "letrero")!)
        
        
        
    }
    
}
