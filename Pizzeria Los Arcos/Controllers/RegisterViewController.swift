//
//  RegisterViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 04/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false

    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        UserDefaults.standard.set(nameField.text, forKey: "name")
        UserDefaults.standard.set(lastnameField.text, forKey: "lastname")
        UserDefaults.standard.set(emailField.text, forKey: "email")
        
    }
    
}
