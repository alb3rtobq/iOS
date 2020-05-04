//
//  UserStatusAction.swift
//  ProyectoFinal
//
//  Created by user169046 on 5/3/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import Foundation
import UIKit

class UserStatusAction {
    
    static func updateRootVC() {
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
       
            print(status)
        

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginBudgetViewController") as! LoginBudgetViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}

