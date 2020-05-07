//
//  RegisterNumberViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 06/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterNumberViewController: UIViewController {
    
    @IBOutlet weak var telefoneNumberField: UITextField!
    @IBOutlet weak var regionField: UITextField!
    
    let region = ["🇲🇽 México (+52)","🇺🇸 Estados Unidos (+1)"]
    var prefix = "+52"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quantityPickerView = UIPickerView()
        quantityPickerView.backgroundColor = UIColor(named: "BrandLightBrow")
        quantityPickerView.delegate = self
        quantityPickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolBar.isUserInteractionEnabled = true
        
        regionField.inputView = quantityPickerView
        regionField.inputAccessoryView = toolBar
        
        quantityPickerView.selectRow(0, inComponent: 0, animated: true)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func verificationCodePressed(_ sender: UIButton) {
        if telefoneNumberField.text != "" {
            if var phoneNumber = telefoneNumberField.text {
                phoneNumber = prefix + phoneNumber
                SVProgressHUD.show()
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                    SVProgressHUD.dismiss()
                    if let error = error {
                        self.alert(title: "¡Ha ocurrido un problema!", message: "\(error.localizedDescription)")
                    } else {
                        UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                        
                        if let vcs = self.navigationController?.viewControllers {
                            let previousVC = vcs[vcs.count - 2]
                            if previousVC is LoginViewController {
                                self.performSegue(withIdentifier: "VerifyAccountToVerificationCode", sender: self)
                            } else {
                                //Navigate to the VerificationCodeViewController
                                self.performSegue(withIdentifier: "RegisterToVerificationCode", sender: self)
                            }
                        }
                        
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


//MARK: - PickerView Data Source

extension RegisterNumberViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return region.count
    }
    
    
}


//MARK: - PickerView & TextField Delegates

extension RegisterNumberViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(region[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currentRegion = region[row]
        
        regionField.text = currentRegion
        
        if currentRegion == "🇲🇽 México (+52)" {
            prefix = "+52"
        } else {
            prefix = "+1"
        }
        
        print(prefix)
    }
    
}
