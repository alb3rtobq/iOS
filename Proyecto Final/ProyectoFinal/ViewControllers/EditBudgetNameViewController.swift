//
//  EditBudgetNameViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/28/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

protocol EditBudgetNameViewControllerProtocol: class {
    func editName(name: String, comment: String)
}

class EditBudgetNameViewController: UIViewController {

    @IBOutlet weak var editBudgetNameLabel: UILabel!
    @IBOutlet weak var newBudgetNameTextField: UITextField!
    @IBOutlet weak var editBudgetCommentLabel: UILabel!
    @IBOutlet weak var newBudgetCommentTextField: UITextField!    
    @IBOutlet weak var cancelEditBudgetNameButton: UIButton!
    
    weak var delegate: EditBudgetNameViewControllerProtocol?
    
    //var name = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        newBudgetNameTextField.becomeFirstResponder()
        //newBudgetNameTextField.text = name
    }    

    @IBAction func editBudgetNameButton(_ sender: Any) {
        if let name = newBudgetNameTextField.text, name.count > 0, let comment = newBudgetCommentTextField.text {
            delegate?.editName(name: name, comment: comment)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelEditBudgetNameAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }     

}
