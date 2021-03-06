//
//  CreatePasswordViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 07/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CreatePasswordViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var verifyPasswordField: UITextField!
    
    let db = Firestore.firestore()
    
    let email = UserDefaults.standard.string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        if passwordField.text == verifyPasswordField.text {
            if let password = passwordField.text, let user = Auth.auth().currentUser {
                SVProgressHUD.show()
                user.updatePassword(to: password, completion: { (error) in
                    SVProgressHUD.dismiss()
                    if let error = error {
                        self.alert(title: "¡Ha ocurrido un error!", message: error.localizedDescription)
                    }
                    
                    if let email = self.email {
                        user.updateEmail(to: email, completion: { (error) in
                            SVProgressHUD.dismiss()
                            if let error = error {
                                self.alert(title: "¡Ha ocurrido un error!", message: error.localizedDescription)
                            }
                            let changeRequest = user.createProfileChangeRequest()
                            if let name = UserDefaults.standard.string(forKey: "name"), let lastName = UserDefaults.standard.string(forKey: "lastname") {
                                changeRequest.displayName = "\(name) \(lastName)"
                                changeRequest.commitChanges { (error) in
                                    if let client = Auth.auth().currentUser?.phoneNumber, let clientName = Auth.auth().currentUser?.displayName {
                                        let docData: [String: Any] = [
                                            "clientName": clientName,
                                            "streaks": 0,
                                            "baned": false
                                        ]
                                        self.db.collection("users").document(client).setData(docData) { err in
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                print("Document successfully written!")
                                            }
                                        }
                                    }
                                }
                            }
                        })
                        self.performSegue(withIdentifier: "CreatePasswordToMenu", sender: self)
                        
                        let alert = UIAlertController(title: "¡Felicidades!", message: "Tu usuario se ha creado correctamente. Por favor no olvides tu usuario ni tu contraseña", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    } else {
                        self.performSegue(withIdentifier: "CreatePasswordToMenu", sender: self)
                        
                        let alert = UIAlertController(title: "Inicio de sesión automático", message: "Tu contraseña se ha restablecido correctamente. Tu correo electrónico es: \(user.email!)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        } else {
            alert(title: "¡Ha ocurrido un error!", message: "Las contraseñas no coinciden, vuelvelo a intentar")
        }
        
    }
    
    func alert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        return
    }
    
}
