//
//  AnimalListViewController.swift
//  AsignacionAdicional
//
//  Created by user169046 on 4/7/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit
import RealmSwift

class AnimalListViewController: UIViewController {
        
    @IBOutlet weak var animalListTableView: UITableView!
    @IBOutlet weak var casaSecc2ImageView: UIImageView!
    
    @IBOutlet weak var casaIzqImageView: UIImageView!
    
    @IBOutlet weak var casaDerImageView: UIImageView!    
 
    let animalTableViewCellIdentifier = "AnimalTableViewCell"
    
    var realmManager = RealmManager()
      
    var animals: Results<Animal>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Vuelve", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = UIColor(red: 1, green: 0.5843, blue: 0, alpha: 1.0)   
        
        animalListTableView.tableFooterView = UIView(frame: .zero)
        self.animalListTableView.backgroundColor = UIColor(red: 1, green: 0.9882, blue: 0.949, alpha: 1.0)
        registerCustomCell()
        
        addAnimalNavigationButton()
        
        casaSecc2ImageView.isHidden = false
                
        loadAnimalList()
    }
    
    func loadAnimalList() {
            let realmManager = RealmManager()
            let animals = realmManager.getAllAnimals()
            if let animals = animals, animals.isEmpty {
              
            } else {
                self.animals = animals
                animalListTableView.reloadData()
            }
    }
    
    func addAnimalNavigationButton() {
        let addAnimalNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAnimalAction(sender:)))
        navigationItem.rightBarButtonItem = addAnimalNavigationButton
    }
    @objc func addAnimalAction(sender: UIBarButtonItem)   {
        if let addAnimalViewController = storyboard?.instantiateViewController(identifier: "AddAnimalViewController") as? AddAnimalViewController {
            addAnimalViewController.delegate = self
            navigationController?.pushViewController(addAnimalViewController, animated: true)
        }
    }
          
    
    func registerCustomCell() {
        let nib = UINib(nibName: animalTableViewCellIdentifier, bundle: nil)
        animalListTableView.register(nib, forCellReuseIdentifier: animalTableViewCellIdentifier)
    }
}

extension AnimalListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if animals?.count == 0 {
            animalListTableView.isHidden = true
            casaIzqImageView.isHidden = true
            casaDerImageView.isHidden =  true
            casaSecc2ImageView.isHidden = false
        }
        else {
            animalListTableView.isHidden = false
            casaIzqImageView.isHidden = false
            casaDerImageView.isHidden =  false
            casaSecc2ImageView.isHidden = true            
        }
        return animals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = animalListTableView.dequeueReusableCell(withIdentifier: animalTableViewCellIdentifier) as? AnimalTableViewCell else {
            let cell = UITableViewCell()
                
            return cell
        }
        if let animal = animals?[indexPath.row] {
            cell.setupCell(animal: animal)
        }
                
        if animals?[indexPath.row].petType == "perrito" {
            if animals?[indexPath.row].likeIt == true {
                cell.dogLikeImageView.isHidden = false
                cell.dogImageView.isHidden = true
                cell.catImageView.isHidden = true
                cell.catLikeImageView.isHidden = true
            } else {
                cell.dogImageView.isHidden = false
                cell.dogLikeImageView.isHidden = true
                cell.catImageView.isHidden = true
                cell.catLikeImageView.isHidden = true
            }
        }
        else if animals?[indexPath.row].petType == "gatito" {
            if animals?[indexPath.row].likeIt == true {
                cell.catLikeImageView.isHidden = false
                cell.catImageView.isHidden = true
                cell.dogImageView.isHidden = true
                cell.dogLikeImageView.isHidden = true
            } else {
                cell.catImageView.isHidden = false
                cell.catLikeImageView.isHidden = true
                cell.dogImageView.isHidden = true
                cell.dogLikeImageView.isHidden = true
            }
        } else {}
        
        if animals?[indexPath.row].petName == "dame un nombre"  {
            cell.petNameLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        }
        
        
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realmManager.deleteAnimal(identifier: (animals?[indexPath.row].identifier)!)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var petMessage = ""
        var statusLikeIt = false
        if animals?[indexPath.row].likeIt == false {
            petMessage = "Este " + (animals?[indexPath.row].petType)! + " te gusta..."
            statusLikeIt = true
        } else {
            petMessage = "Este " + (animals?[indexPath.row].petType)! + " ya no te gusta..."
            statusLikeIt = false
        }
        
        let refreshAlert = UIAlertController(title: "Me gusta...", message: petMessage, preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.realmManager.modifyAnimal(identifier: (self.animals?[indexPath.row].identifier)!, statusLikeIt: statusLikeIt)
                    
            tableView.reloadData()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
}

extension AnimalListViewController: AddAnimalViewControllerProtocol {
    func addAnimal(animal: Animal) {
        realmManager.addAnimal(animal: animal)
        navigationController?.popViewController(animated: true)        
        loadAnimalList()
    }
}

