//
//  BudgetHelpViewController.swift
//  ProyectoFinal
//
//  Created by user169046 on 5/2/20.
//  Copyright © 2020 user169046. All rights reserved.
//

import UIKit

class BudgetHelpViewController: UIViewController {
    

    @IBOutlet weak var help1View: UIView!
    @IBOutlet weak var help2View: UIView!
    @IBOutlet weak var help3View: UIView!
    @IBOutlet weak var help4View: UIView!
    @IBOutlet weak var help5View: UIView!
    
    @IBOutlet weak var help1Button: UIButton!
    @IBOutlet weak var help2Button: UIButton!
    @IBOutlet weak var help3Button: UIButton!
    @IBOutlet weak var help4Button: UIButton!
    @IBOutlet weak var help5Button: UIButton!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        help1View.isHidden = false
        help2View.isHidden = true
        help3View.isHidden = true
        help4View.isHidden = true
        help5View.isHidden = true
        help1Button.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
    }
    
    @IBAction func help1Button(_ sender: Any) {
        help1View.isHidden = false
        help2View.isHidden = true
        help3View.isHidden = true
        help4View.isHidden = true
        help5View.isHidden = true
        help1Button.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
    }
    
    @IBAction func help2Button(_ sender: Any) {
        help1View.isHidden = true
        help2View.isHidden = false
        help3View.isHidden = true
        help4View.isHidden = true
        help5View.isHidden = true
        help2Button.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)        
    }
    
    @IBAction func help3Button(_ sender: Any) {
        help1View.isHidden = true
        help2View.isHidden = true
        help3View.isHidden = false
        help4View.isHidden = true
        help5View.isHidden = true
        help3Button.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
    }
    
    @IBAction func help4Button(_ sender: Any) {
        help1View.isHidden = true
        help2View.isHidden = true
        help3View.isHidden = true
        help4View.isHidden = false
        help5View.isHidden = true
        help4Button.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
    }
    
    @IBAction func help5Button(_ sender: Any) {
        help1View.isHidden = true
        help2View.isHidden = true
        help3View.isHidden = true
        help4View.isHidden = true
        help5View.isHidden = false
        help5Button.tintColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1.0)
    }
}
