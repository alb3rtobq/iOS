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
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            if let tabBarController = storyboard?.instantiateViewController(identifier: "TabBarViewController") {
                tabBarController.modalPresentationStyle = .fullScreen
                present(tabBarController, animated: true, completion: nil)
            }
        }
    
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
}
    
    @IBAction func loginUserAction(_ sender: Any) {
        if textUserNameTextField.text == "Cesar" && textPasswordTextField.text == "123" {
            UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            if let tabBarController = storyboard?.instantiateViewController(identifier: "TabBarViewController") {
                tabBarController.modalPresentationStyle = .fullScreen
                present(tabBarController, animated: true, completion: nil)
            }
            
        }
    }
    
}
