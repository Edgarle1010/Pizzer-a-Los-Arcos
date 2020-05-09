//
//  BeforOrderQuarterViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 19/04/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox

class BreakfastsViewController: UIViewController {
    
    @IBOutlet weak var halfOrderButton: UIButton!
    @IBOutlet weak var completeOrderButton: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var extraIngredientNumerLabel: UILabel!
    @IBOutlet weak var extraIngredientStepper: UIStepper!
    @IBOutlet weak var extraIngredientLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var foodName: String?
    var foodType: String?
    
    var food = FoodMenu()
    var quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var quantitySplit = 1
    var oldValue: Double = 0
    
    var sizeCurrent = "Orden completa"
    var currentPrice: Double = 0
    var extraPrice: Double = 0
    var extraIngredients = [String:Int]()

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
        
        quantityPickerView.selectRow(0, inComponent: 0, animated: true)
        
        getTotal()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    func getTotal() {
        
        if sizeCurrent == "Media orden" {
            currentPrice = ((Double(food.desayunos.filter{$0.name == foodName}[0].price) * 0.70) + extraPrice) * Double(quantitySplit)
        } else {
            currentPrice = (Double(food.desayunos.filter{$0.name == foodName}[0].price) + extraPrice) * Double(quantitySplit)
        }
        
        totalLabel.text = "$\(String(format: "%.2f", currentPrice))"
    }
    
    @IBAction func sizeChanged(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        halfOrderButton.isSelected = false
        completeOrderButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        sizeCurrent = sender.currentTitle!
        
        getTotal()
    }
    
    @IBAction func extraIngredientValueChanged(_ sender: UIStepper) {
        
        if (sender.value>oldValue) {
            oldValue += 1
            //Your Code You Wanted To Perform On Increment
            performSegue(withIdentifier: "BreakfastsToExtra", sender: self)
        } else {
            oldValue=oldValue-1
            //Your Code You Wanted To Perform On Decrement
            var lastExtraIngredient: String?
            for data in extraIngredients {
                lastExtraIngredient = data.key
            }
            
            if let last = lastExtraIngredient {
                extraIngredients.removeValue(forKey: last)
                
                extraIngredientLabel.text = ""
                extraPrice = 0
                
                for data in extraIngredients {
                    extraIngredientLabel.text?.append("\(data.key)")
                    extraPrice += Double(data.value)
                }
            }
        }
        
        extraIngredientNumerLabel.text = String(Int(sender.value))
        
        getTotal()
        
        if (sender.value != 0) {
            halfOrderButton.isEnabled = false
            completeOrderButton.isEnabled = false
            quantityTextField.isEnabled = false
        } else {
            halfOrderButton.isEnabled = true
            completeOrderButton.isEnabled = true
            quantityTextField.isEnabled = true
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        OrdersList.ordersList.append(Orders(foodName: "\(sizeCurrent): \(foodName!)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BreakfastsToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.isModalInPresentation = true
            destinationVC.sizeCurrent = sizeCurrent
            destinationVC.quantity = quantitySplit
            destinationVC.foodType = foodType
        }
    }
    
    
}


//MARK: - PickerView Data Source

extension BreakfastsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantity.count
    }
    
}


//MARK: - PickerView & TextField Delegates

extension BreakfastsViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(quantity[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        quantitySplit = quantity[row]
        quantityTextField.text = String(quantitySplit)
        
        getTotal()
    }
    
}
