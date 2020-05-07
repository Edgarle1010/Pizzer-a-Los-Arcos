//
//  BurgerViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 26/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox

class BurgerViewController: UIViewController {
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var extraIngredientNumberLabel: UILabel!
    @IBOutlet weak var extraIngredientStepper: UIStepper!
    @IBOutlet weak var extraIngredientLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var foodName: String?
    var foodType: String?
    
    var food = FoodMenu()
    var quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var quantitySplit: Double = 1
    var extraIngredientSplit = 0
    var extraIngredients = [String:Int]()
    var oldValue: Double = 0
    
    var currentPrice: Double = 0
    var extraPrice = 0
    var lastExtra = ""
    
    
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
        
        quantityTextField.inputView = quantityPickerView
        quantityTextField.inputAccessoryView = toolBar
        
        quantityPickerView.selectRow(Int(quantitySplit-1), inComponent: 0, animated: true)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        getTotal()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }

    @IBAction func extraIngredientValueChange(_ sender: UIStepper) {
        
        if (sender.value>oldValue) {
            oldValue += 1
            //Your Code You Wanted To Perform On Increment
            performSegue(withIdentifier: "BurguerToExtra", sender: self)
        }
        else {
            oldValue=oldValue-1
            //Your Code You Wanted To Perform On Decrement
            for data in extraIngredients {
                lastExtra = data.key
            }
            extraIngredients.removeValue(forKey: lastExtra)
            extraIngredientLabel.text = ""
            extraPrice = 0
            for data in extraIngredients {
                extraIngredientLabel.text?.append("\(data.key)")
                extraPrice += data.value
            }
        }
        
        if (sender.value != 0) {
            quantityTextField.isEnabled = false
            quantityTextField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            quantityTextField.isEnabled = true
            quantityTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        extraIngredientSplit = Int(sender.value)
        extraIngredientNumberLabel.text = String(extraIngredientSplit)
        
        getTotal()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        OrdersList.ordersList.append(Orders(foodName: "\(foodName!)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
        
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
        case "Hamburguesas":
            currentPrice = Double(food.hamburguesas.filter{$0.name == foodName}[0].price + extraPrice) * quantitySplit
        case "Ensaladas":
            currentPrice = Double(food.ensaladas.filter{$0.name == foodName}[0].price + extraPrice) * quantitySplit
        case "Platillos":
            currentPrice = Double(food.platillos.filter{$0.name == foodName}[0].price + extraPrice) * quantitySplit
        case "Mariscos":
            currentPrice = Double(food.mariscos.filter{$0.name == foodName}[0].price + extraPrice) * quantitySplit
        case "Desayunos":
            currentPrice = Double(food.desayunos.filter{$0.name == foodName}[0].price + extraPrice) * quantitySplit
        default: break
        }
        
        totalLabel.text = "$\(String(currentPrice))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BurguerToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.isModalInPresentation = true
            destinationVC.quantity = Int(quantitySplit)
            destinationVC.foodType = foodType
        }
    }
}


//MARK: - PickerView Data Source

extension BurgerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantity.count
    }
    
    
}


//MARK: - PickerView & TextField Delegates

extension BurgerViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(quantity[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quantitySplit = Double(quantity[row])
        quantityTextField.text = String(format: "%.0f", quantitySplit)
        
        getTotal()
    }
    
}
