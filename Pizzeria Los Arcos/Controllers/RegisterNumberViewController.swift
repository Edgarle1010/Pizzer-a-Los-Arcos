//
//  RegisterNumberViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 06/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase

class RegisterNumberViewController: UIViewController {
    
    @IBOutlet weak var telefoneNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func verificationCodePressed(_ sender: UIButton) {
        if telefoneNumberField.text != "" {
            if var phoneNumber = telefoneNumberField.text {
                phoneNumber = "+52" + phoneNumber
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                    if let error = error {
                        self.alert(title: "¡Ha ocurrido un problema!", message: "\(error.localizedDescription)")
                    } else {
                        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                        
                        //Navigate to the VerificationCodeViewController
                        self.performSegue(withIdentifier: "RegisterToVerificationCode", sender: self)
                    }
                }
            }
        } else {
            alert(title: "Alerta", message: "El campo esta vacío")
        }
    }
    
    func alert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
}
