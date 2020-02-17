//
//  VericationCodeViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 07/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase

class VericationCodeViewController: UIViewController {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var verificationCodeText: UITextField!
    
    let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
    let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showMessagePrompt = UIAlertController(title: nil, message: "En breve recibiras un código de seguridad para verificar tu número", preferredStyle: .alert)
        showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
            NSLog("Verification code send")
        }))
        self.present(showMessagePrompt, animated: true, completion: nil)
        
        numberLabel.text = ("\(numberLabel.text!) \(phoneNumber!)")

    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        if let verificationCode = verificationCodeText.text {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El código de seguirdad es incorrecto", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                        NSLog(error.localizedDescription)
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    //Navigate to the CreatePasswordViewController
                    self.performSegue(withIdentifier: "VerificationCodeToCreatePassword", sender: self)
                }
            }
        }
        
    }
    
}
