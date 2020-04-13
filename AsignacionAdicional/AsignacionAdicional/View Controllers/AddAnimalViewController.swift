//
//  AddAnimalViewController.swift
//  AsignacionAdicional
//
//  Created by user169046 on 4/7/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

protocol AddAnimalViewControllerProtocol: class {
    func addAnimal(animal: Animal)
}

class AddAnimalViewController: UIViewController {

    //@IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var petTypeImageView: UIImageView!
    @IBOutlet weak var petTypePickerView: UIPickerView!
    @IBOutlet weak var petNameTextField: UITextField!   
    
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var ownerPhoneTextField: UITextField!
    
    @IBOutlet weak var petLocationPickerView: UIPickerView!
    @IBOutlet weak var petLocationLabel: UILabel!
    
    @IBOutlet weak var dogPetTypeImageView: UIImageView!
    @IBOutlet weak var catPetTypeImageView: UIImageView!
    
    @IBOutlet weak var phrasesLabel: UILabel!
        
    
    let petTypePickerViewData = ["...perro o gato...", "perrito", "gatito"]
    var petType = "...perro o gato..."
    
    let petLocationPickerViewData = ["San Jose","Alajuela","Heredia","Cartago","Puntarenas","Guanacaste","Limon"]
    var petLocation = ""
    
    var phrasesId = 0
    let phrases = ["Dios creo al gato para acariciar al tigre", "Errar es humano,ronronear es felino,ladrar es canino...", "Mala suerte el que se cruce con un humano ignorante. (El gato negro)", "«Miau» significa «guau» en el lenguaje gatuno", "Los gatos nos escogen; no somos sus dueños", "La curiosidad mató al gato", "Los perros comen. Los gatos cenan", "El sonido universal de la paz: el ronroneo"]

    weak var delegate: AddAnimalViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimalNavigationButton()
        
        petTypePickerView.dataSource = self
        petTypePickerView.delegate = self
        
        petLocationPickerView.dataSource = self
        petLocationPickerView.delegate = self
        
        dogPetTypeImageView.isHidden = true
        catPetTypeImageView.isHidden = true
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 1, green: 0.5843, blue: 0, alpha: 1.0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
        view.addGestureRecognizer(tapGesture)
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(AddAnimalViewController.phrasesLabelChange), userInfo: nil, repeats: true)
        
    }
     
    func AnimalNavigationButton() {
        let addNavigationButton = UIBarButtonItem(title: "Rescatar", style: .plain, target: self, action: #selector(addAnimalAction(sender:)))
        navigationItem.rightBarButtonItem = addNavigationButton
    }
    
    @objc func addAnimalAction(sender: UIBarButtonItem)   {
        
        var errorMessage = ""
        if petType != "...perro o gato..." && petLocation != "" {
            
            if let petName = petNameTextField.text, petName.count > 0,let owner = ownerNameTextField.text, owner.count > 0, let phone = ownerPhoneTextField.text, phone.count > 0 {
                      
                let animal = Animal(petName: petName, petType: petType, ownerName: owner, phone: phone, location: petLocation, likeIt: false)
                      delegate?.addAnimal(animal: animal)
                      }
                  else {
                      if let petName = petNameTextField.text, petName.count == 0 {
                          errorMessage = "Favor ingrese el nombre de su mascota, para omitirlo presione la etiqueta roja"
                          }
                          else { errorMessage = "Favor ingrese la información de contacto" }
                        let alertController = UIAlertController(title: "Problemas para rescatar tu mascota ... ?", message: errorMessage, preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(action)
                        present(alertController, animated: true, completion: nil)
                      }
        } else {
            
            if petType == "...perro o gato..." { errorMessage = "Favor elija el tipo de mascota :  'perrito' o 'gatito'" }
            else { errorMessage = "Favor elija la provincia donde vive su mascota" }
            let alertController = UIAlertController(title: "Problemas para rescatar tu mascota... ?", message: errorMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            }
    }
    
    func petTypeImage() {
        if petType == "perrito" {
            dogPetTypeImageView.isHidden = false
            catPetTypeImageView.isHidden = true
            petTypeImageView.isHidden = true
        } else {
            if petType == "gatito" {
                catPetTypeImageView.isHidden = false
                dogPetTypeImageView.isHidden = true
                petTypeImageView.isHidden = true
            } else {
                catPetTypeImageView.isHidden = true
                dogPetTypeImageView.isHidden = true
                petTypeImageView.isHidden = false
            }
        }
    }
    
    @IBAction func tagNameButton(_ sender: Any) {        
        if petType == "perrito" {
            petNameTextField.text = "dame un nombre"
        }
        else { if petType == "gatito" {
            petNameTextField.text = "dame un nombre"
            }
        else { }
    }
    }
    
    @objc func tapGestureHandler() {
        petNameTextField.endEditing(true)
        ownerNameTextField.endEditing(true)
        ownerPhoneTextField.endEditing(true)
  }
    
    @objc func phrasesLabelChange()
    {
        if phrasesId != 7 {
            phrasesId+=1
        }
        else {
            phrasesId = 0
        }
        phrasesLabel.text = phrases[phrasesId]        
    }

}


extension AddAnimalViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return petTypePickerViewData.count
        } else {
            return petLocationPickerViewData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            petType = petTypePickerViewData[row]
            petTypeImage()
        } else {
            petLocationLabel.text = petLocationPickerViewData[row]
            petLocation = petLocationPickerViewData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return petTypePickerViewData[row]
        } else {
            return petLocationPickerViewData[row]
        }
    }
    
    
}





