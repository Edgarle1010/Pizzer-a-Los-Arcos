//
//  BeforeOrderThirdViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 01/03/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox

class BeforeOrderThirdViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var foodType: String?
    var foodName: String?
    var food = FoodMenu()
    
    var flavors = [""]
    var nameFlavor: String?
    var quantity = [1, 2, 3, 4, 5]
    var quantitySplit: Double = 1
    var extraIngredients = [String:Int]()
    
    var currentPrice: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if foodType == "Bebidas" {
            switch foodName {
            case K.Bebidas.Refrescos.name:
                flavors = ["Coca Cola", "Sprite", "Fresca", "Sidral Mundet", "Naranja", "Coca Cola Light", "Coca Cola sin azucar"]
            case K.Bebidas.Cappuccino.name:
                flavors = ["Original", "Vainilla"]
            case K.Bebidas.Chocolate.name:
                flavors = ["Frío", "Caliente"]
            case K.Bebidas.Licuado.name:
                flavors = ["Plátano", "Nuez"]
            default:
                break
            }
        } else if foodType == "Postres" {
            switch foodName {
            case K.Postres.PastelChocolateNieve.name, K.Postres.PayQuesoNieve.name, K.Postres.PayNuezNieve.name:
                flavors = ["Vainilla", "Fresa", "Combinada"]
            default:
                break
            }
        } else if foodType == "Nieves" {
            switch foodName {
            case K.NievesMalteadas.Malteada.name:
                flavors = ["Piña colada", "Vainilla", "Fresa", "Chocolate"]
            default:
                flavors = ["Vainilla", "Fresa", "Combinada"]
                break
            }
        }
        
        nameFlavor = flavors[0]
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
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
        
        quantityTextField.inputView = quantityPickerView
        quantityTextField.inputAccessoryView = toolBar
        
        quantityPickerView.selectRow(Int(quantitySplit), inComponent: 0, animated: true)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        getTotal()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        OrdersList.ordersList.append(Orders(foodName: "\(foodName!), \(nameFlavor!)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(OrdersList.ordersList)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate) {
        }
        
        let alert = UIAlertController(title: nil, message: "¡Producto agregado correctamente!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getTotal() {
        
        switch foodType {
        case "Bebidas":
            currentPrice = Double(food.bebidas.filter{$0.name == foodName}[0].price) * quantitySplit
        case "Postres":
            currentPrice = Double(food.postres.filter{$0.name == foodName}[0].price) * quantitySplit
        case "Nieves":
            currentPrice = Double(food.nieves.filter{$0.name == foodName}[0].price) * quantitySplit
        default:
            break
        }
        
        totalLabel.text = "$\(String(currentPrice))"
    }
    
}

extension BeforeOrderThirdViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.pickerView {
            return flavors.count
        } else {
            return quantity.count
        }
    }
}

extension BeforeOrderThirdViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.pickerView {
            return flavors[row]
        } else {
            return String(quantity[row])
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.pickerView {
            nameFlavor = flavors[row]
            self.view.endEditing(true)
            getTotal()
        } else {
            quantitySplit = Double(quantity[row])
            self.quantityTextField.text = String(format: "%.0f", quantitySplit)
            self.view.endEditing(true)
            getTotal()
        }
        
    }
}
