//
//  SettingViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 3/24/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit
import RealmSwift

class SettingViewController: UIViewController {
    
    @IBOutlet weak var deleteAllAppContentsLabel: UILabel!
    @IBOutlet weak var versionNumberLabel: UILabel!
    
    var budgets: Results<Budget>?
    
    let version: String = (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String)!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionNumberLabel.text = version
    }
        
    @IBAction func deleteAllAppContentsButton(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "COIN to COIN 2020", message: "Presione OK para iniciar...", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            let realmManager = RealmManager()
            realmManager.deleteAllBudgets()
            
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
}
