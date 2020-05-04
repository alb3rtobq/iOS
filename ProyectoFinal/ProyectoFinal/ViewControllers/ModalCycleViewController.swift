//
//  modalCycleViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 4/14/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

protocol ModalCycleViewControllerProtocol: class {
    func addCycle(period: String, date: Date)
}

class ModalCycleViewController: UIViewController {    
   
    @IBOutlet weak var budgetStartDateLabel: UILabel!
    @IBOutlet weak var budgetStartDatePicker: UIDatePicker!
    @IBOutlet weak var budgetPeriodLabel: UILabel!
    @IBOutlet weak var budgetPeriodPickerView: UIPickerView!
    
    let budgetPeriodPickerViewData = ["Mensual", "Quincenal", "Semanal"]
    
    var period = "Mensual"   
    
    weak var delegate : ModalCycleViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetPeriodPickerView.dataSource = self
        budgetPeriodPickerView.delegate = self
        
        budgetStartDatePicker.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        budgetPeriodPickerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        
        budgetStartDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        budgetStartDatePicker.setValue(false, forKeyPath: "highlightsToday")        
    }
        
    @IBAction func modalCycleButton(_ sender: Any) {
        delegate?.addCycle(period: period, date: budgetStartDatePicker.date)
        dismiss(animated: true, completion: nil)
    }        
     
    @IBAction func setCurrentDayButton(_ sender: Any) {
        budgetStartDatePicker.date = Date()
    }
}

extension ModalCycleViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return budgetPeriodPickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        period = budgetPeriodPickerViewData[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return budgetPeriodPickerViewData[row]
    }
}

