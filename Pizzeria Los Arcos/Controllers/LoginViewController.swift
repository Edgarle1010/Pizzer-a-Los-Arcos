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
    @IBOutlet weak var recoverPasswordLabel: UILabel!
    @IBOutlet weak var registerAccount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.tapFunction))
        let registerTap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.registerTapFunction))
        recoverPasswordLabel.addGestureRecognizer(tap)
        registerAccount.addGestureRecognizer(registerTap)
        
        // Create attributed string
        let myAttribute = [ NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue ]
        let myAttrRecover = NSAttributedString(string: recoverPasswordLabel.text!, attributes: myAttribute)
        let myAttrRegister = NSAttributedString(string: registerAccount.text!, attributes: myAttribute)

        // Set attributed text on a UILabel
        recoverPasswordLabel.attributedText = myAttrRecover
        registerAccount.attributedText = myAttrRegister
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
    
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "RecoverPasswordToVerifyAccounnt", sender: self)
    }
    
    @objc func registerTapFunction(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "LoginToRegistry", sender: self)
    }
    
}
