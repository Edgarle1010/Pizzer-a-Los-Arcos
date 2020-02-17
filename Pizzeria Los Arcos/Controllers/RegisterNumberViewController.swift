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
        
    }
    
    @IBAction func verificationCodePressed(_ sender: UIButton) {
        
        if var phoneNumber = telefoneNumberField.text {
            
            phoneNumber = "+52" + phoneNumber
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El número de celular introducido es incorrecto", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                        NSLog(error.localizedDescription)
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                    
                    //Navigate to the VerificationCodeViewController
                    self.performSegue(withIdentifier: "RegisterToVerificationCode", sender: self)
                    
                }
                
            }
            
        }
        
    }
    
}
