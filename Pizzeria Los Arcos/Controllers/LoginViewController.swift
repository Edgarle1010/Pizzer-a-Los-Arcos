//
//  LoginViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 04/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                SVProgressHUD.dismiss()
                if let error = error {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                        NSLog(error.localizedDescription)
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                }
                
                //Navigate to the MenuViewController
                self.performSegue(withIdentifier: "LoginToMenu", sender: self)
            }
        }
    }
    
}
