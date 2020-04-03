//
//  RegisterViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 04/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        nameField.delegate = self
        lastnameField.delegate = self
        emailField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if nameField.text != "" && lastnameField.text != "" && emailField.text != "" {
            
            let email = isValidEmail(emailField.text!)
            
            if email {
                UserDefaults.standard.set(nameField.text, forKey: "name")
                UserDefaults.standard.set(lastnameField.text, forKey: "lastname")
                UserDefaults.standard.set(emailField.text, forKey: "email")
            } else {
                alert(title: "Alerta", message: "El formato del email introducido no es correcto")
            }
            
        } else {
            alert(title: "Alerta", message: "Uno o más campos estan vacios. Ingresa los datos solicitados")
        }
    }
    
    func alert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
}
