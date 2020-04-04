//
//  Item.swift
//  Tarea#3
//
//  Created by user169046 on 3/22/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation

struct Item {
    
    var identifier =  NSUUID().uuidString
    //var imageName : String
    var name: String
    var number: String
    var date = Date()
    var unit: String
    var priority: String
    var inKartProduct : Bool   
    
    
    //init(imageName: String, name: String, number: String, date: Date) {
      //  self.imageName = imageName
        //self.name = name
        //self.number = number
      //  self.date = date    
    //}
}

   


