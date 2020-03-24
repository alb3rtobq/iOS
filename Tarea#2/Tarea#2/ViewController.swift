//
//  ViewController.swift
//  Tarea#2
//
//  Created by user169046 on 3/23/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 101
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            let cell = UITableViewCell()
            if indexPath.row != 0 {
                if indexPath.row % 2 == 0 {
                    cell.textLabel?.text = String(indexPath.row) + " - PAR"
                    cell.contentView.backgroundColor = UIColor.red                    
                }
                else {
                    cell.textLabel?.text = String(indexPath.row) + " - IMPAR"
                    cell.contentView.backgroundColor = UIColor.blue
                }
            }
            
            return cell
        }
        return cell
    }
    
    
}
