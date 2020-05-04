//
//  LoginBudgetViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/30/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class LoginBudgetViewController: UIViewController {

    @IBOutlet weak var textUserNameTextField: UITextField!
    
    @IBOutlet weak var textPasswordTextField: UITextField!
    
    @IBOutlet weak var loginBudgetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBudgetButton.layer.cornerRadius = 10
        loginBudgetButton.layer.masksToBounds = true
    
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
                
}
        
    @IBAction func loginUserAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "status")
        UserStatusAction.updateRootVC()
        
        
        //let budgetList = self.storyboard?.instantiateViewController(withIdentifier: "BudgetListViewController") as! //BudgetListViewController
        //self.navigationController?.pushViewController(budgetList, animated: true)
       
    }
    
    
}
