//
//  ExtraIngredientViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 12/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class ExtraIngredientViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var foodType: String?
    var extraOpt: [Extra] = []
    var back: UIViewController?
    
    var extraList = ExtraIngredientMenu()
    var sizeCurrent = ""
    var nameExtra = ""
    var priceExtra = 0
    var quantity: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if foodType == "Pizzas" {
            extraOpt = extraList.pizza.filter { $0.size == sizeCurrent }
        } else {
            extraOpt = extraList.others
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.nameExtra = self.extraOpt[0].name
        self.priceExtra = self.extraOpt[0].price
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        if foodType == "Pizzas" {
            if let backVC = presentingViewController as? BeforeOrderViewController {
                
                if backVC.extraIngredients["(Cantidad: \(Int(quantity))) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(Int(quantity))) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Int(Double(priceExtra) * quantity)
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
                
            }
            
        } else {
            if let backVC = presentingViewController as? BeforeOrderSecondViewController {
                
                if backVC.extraIngredients["(Cantidad: \(Int(quantity))) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(Int(quantity))) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Int(Double(priceExtra) * quantity)
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
                
            }
            
        }
        
    }
    
}

extension ExtraIngredientViewController: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return extraOpt.count
    }
    
}

extension ExtraIngredientViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(extraOpt[row].name) ($\(extraOpt[row].price))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameExtra = extraOpt[row].name
        priceExtra = extraOpt[row].price
    }
    
}

