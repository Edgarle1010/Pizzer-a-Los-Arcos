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
    
    var extraList = ExtraList()
    var sizeCurrent = ""
    var nameExtra = ""
    var priceExtra = 0
    var quantity = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.nameExtra = self.extraList.extraOpt[0].name
        self.priceExtra = self.extraList.extraOpt[0].price

    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        if let backVC = presentingViewController as? BeforeOrderViewController {
            
            if let extra = backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] {
                let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                }))
                self.present(showMessagePrompt, animated: true, completion: nil)
                return
            }
            
            backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
            backVC.extraIngredientLabel.text = ""
            priceExtra = 0
            for data in backVC.extraIngredients {
                backVC.extraIngredientLabel.text?.append("\(data.key)")
                priceExtra += data.value
            }
            backVC.extraPrice = priceExtra * quantity
            backVC.viewDidLoad()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension ExtraIngredientViewController: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        extraList.extraOpt = extraList.extra.filter { $0.size == sizeCurrent } 
        return extraList.extraOpt.count
    }
    
}

extension ExtraIngredientViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(extraList.extraOpt[row].name) ($\(extraList.extraOpt[row].price))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameExtra = extraList.extraOpt[row].name
        priceExtra = extraList.extraOpt[row].price
    }
    
}

