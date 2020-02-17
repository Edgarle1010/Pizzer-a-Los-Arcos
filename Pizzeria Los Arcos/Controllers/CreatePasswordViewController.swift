//
//  CreatePasswordViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 07/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase

class CreatePasswordViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    
    let email = UserDefaults.standard.string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let password = passwordField.text {
            Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
                if let error = error {
                    let showMessagePrompt = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                        NSLog(error.localizedDescription)
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                }
                
                Auth.auth().currentUser?.updateEmail(to: self.email!, completion: { (error) in
                    print("Error al guardar el email")
                })
                
                self.performSegue(withIdentifier: "CreatePasswordToMenu", sender: self)
                
            })
        }
        
    }
    
}
