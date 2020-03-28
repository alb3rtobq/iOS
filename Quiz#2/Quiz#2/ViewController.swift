//
//  ViewController.swift
//  Quiz#2
//
//  Created by user169046 on 3/28/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let multiplicarTableViewCellIdentifier = "multiplicarTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomCell()
        // Do any additional setup after loading the view.
    }
    
    func registerCustomCell() {
        let nib = UINib(nibName: multiplicarTableViewCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: multiplicarTableViewCellIdentifier)
    }

    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            let cell = UITableViewCell()
            let ocho = 8            
            
            cell.textLabel?.text = String(ocho * indexPath.row)
            return cell
        }
        return cell    }
    
    
}

