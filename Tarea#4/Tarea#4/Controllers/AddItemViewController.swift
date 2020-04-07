//
//  AddItemViewController.swift
//  Tarea#3
//
//  Created by user169046 on 3/22/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

protocol AddItemViewControllerProtocol: class {
    func addItem(item: Item)
}

class AddItemViewController: UIViewController {   
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var unitsTextLabel: UILabel!
    @IBOutlet weak var unitsPickerView: UIPickerView!
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    let unitsPickerViewData = ["unidad", "Kg", "bolsa", "caja"]
    var item: Item?
    var select = "3"
    
    weak var delegate: AddItemViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveItemNavigationButton()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AddItemViewController.add), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
        
        unitsPickerView.dataSource = self
        unitsPickerView.delegate = self
        
    }
    @objc func add() {
      nameTextField.becomeFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func saveItemNavigationButton() {
        let addNavigationButton = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(addItemAction(sender:)))
        navigationItem.rightBarButtonItem = addNavigationButton
    }
    
    @objc func addItemAction(sender: UIBarButtonItem)   {
        var message = ""
        if let name = nameTextField.text, name.count > 0, let number = numberTextField.text, number.count > 0, var unit = unitsTextLabel.text, unit.count >= 0 {
            if unit.count == 0 {
                if number == "1" {
                    unit = "unidad"
                }
                else {
                    unit = "unidades"
                }
            } else {
                if number > "1" {
                    if unit == "unidad" {unit = "unidades"} else {if unit == "bolsa" {unit = "bolsas"} else {if unit == "caja" {unit = "cajas"} } }
                } else {}
                }
            let item = Item(name: name, number: number, unit: unit, priority: select, inKartProduct: false)
                delegate?.addItem(item: item)                
        } else {
            
            if let name = nameTextField.text, name.count == 0, let number = numberTextField.text, number.count == 0 {
                    message = "Favor ingrese producto y cantidad" }
            else {
                    message = "Favor ingrese cantidad" }
                
            let alertController = UIAlertController(title: "Problemas con su carrito... ?", message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }        
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            select = "2"
        } else {
            if sender.selectedSegmentIndex == 2 {
                select = "1"
            } else {
                
            }
        }
    }    
    
}

extension AddItemViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitsPickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        unitsTextLabel.text = unitsPickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitsPickerViewData[row]
    }
    
    
}



    

