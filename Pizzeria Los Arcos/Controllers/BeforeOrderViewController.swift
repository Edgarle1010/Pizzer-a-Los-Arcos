//
//  BeforeOrderViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox

class BeforeOrderViewController: UIViewController {
    
    @IBOutlet weak var smallPctButton: UIButton!
    @IBOutlet weak var mediumPctButton: UIButton!
    @IBOutlet weak var bigPctButton: UIButton!
    @IBOutlet weak var extraIngredientNumberLabel: UILabel!
    @IBOutlet weak var extraIngredientLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var extraIngredientStepper: UIStepper!
    @IBOutlet weak var halfLabel: UILabel!
    
    var foodName: String?
    var foodType: String?
    
    var food = FoodMenu()
    var quantity = [0.5, 1, 2, 3, 4, 5]
    
    var quantitySplit: Double = 1
    var extraIngredientSplit = 0
    var oldValue: Double = 0
    
    var sizeCurrent = "Grande"
    var currentPrice: Double = 0
    var extraPrice = 0
    var halfPrice: Double = 0
    var halfName: String?
    var extraIngredients = [String:Int]()
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
        
        quantityPickerView.selectRow(Int(quantitySplit), inComponent: 0, animated: true)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        getTotal()
    }
    
    func getTotal() {
        if halfPrice == 0 {
            currentPrice = Double(food.getPizzaPrice(name: foodName!, size: sizeCurrent) + extraPrice) * quantitySplit
        } else {
            currentPrice = (Double(food.getPizzaPrice(name: foodName!, size: sizeCurrent) / 2) + halfPrice) + Double(extraPrice)
        }
        
        totalLabel.text = "$\(String(currentPrice))"
    }
    
    func resetView() {
        halfPrice = 0
        halfLabel.text = ""
        extraPrice = 0
        extraIngredientLabel.text = ""
        extraIngredients.removeAll()
        extraIngredientStepper.value = 0
        extraIngredientSplit = 0
        extraIngredientNumberLabel.text = "0"
        oldValue = 0
        
        view.endEditing(true)
        getTotal()
    }
    
    @IBAction func sizeChanged(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        smallPctButton.isSelected = false
        mediumPctButton.isSelected = false
        bigPctButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        quantitySplit = 1
        quantityTextField.text = "1"
        
        //Get the current title of the button that was pressed.
        sizeCurrent = sender.currentTitle!
        
        resetView()
    }
    
    @IBAction func extraIngredientValueChangue(_ sender: UIStepper) {
        if (sender.value>oldValue) {
            oldValue += 1
            //Your Code You Wanted To Perform On Increment
            performSegue(withIdentifier: "PreOrderToExtra", sender: self)
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
            
            getTotal()
        }
        
        extraIngredientSplit = Int(sender.value)
        extraIngredientNumberLabel.text = String(extraIngredientSplit)
        
        getTotal()
        
        if (sender.value != 0) {
            smallPctButton.isEnabled = false
            mediumPctButton.isEnabled = false
            bigPctButton.isEnabled = false
            quantityTextField.isEnabled = false
        } else {
            smallPctButton.isEnabled = true
            mediumPctButton.isEnabled = true
            bigPctButton.isEnabled = true
            quantityTextField.isEnabled = true
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        if foodType == "Pizzas" {
            if let half = halfName {
                OrdersList.ordersList.append(Orders(foodName: "Mitad: \(foodName!) - Mitad: \(half), \(sizeCurrent)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text))
            } else {
                OrdersList.ordersList.append(Orders(foodName: "\(foodName!), \(sizeCurrent)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
            }
        } else {
            OrdersList.ordersList.append(Orders(foodName: "\(foodName!)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
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
        if segue.identifier == "PreOrderToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.isModalInPresentation = true
            destinationVC.sizeCurrent = sizeCurrent
            destinationVC.quantity = quantitySplit
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "PreOrderToHalf" {
            let destinationVC = segue.destination as! HalfTableViewController
            destinationVC.isModalInPresentation = true
            destinationVC.pizzaSize = sizeCurrent
        }
    }
    
}


//MARK: - PickerView Data Source

extension BeforeOrderViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantity.count
    }
    
    
}


//MARK: - PickerView & TextField Delegates

extension BeforeOrderViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if quantity[row] == 0.5 {
            return String(quantity[row])
        }
        return String(format: "%.0f", quantity[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        quantitySplit = quantity[row]
        if quantitySplit == 0.5 {
            self.quantityTextField.text = String(quantitySplit)
            let showMessagePrompt = UIAlertController(title: nil, message: "¿Quieres tu pizza mitad y mitad?", preferredStyle: .alert)
            showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Defalut action"), style: .default, handler: { (_) in
                self.view.endEditing(true)
                self.performSegue(withIdentifier: "PreOrderToHalf", sender: self)
            }))
            showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (_) in
                pickerView.selectRow(1, inComponent: 0, animated: true)
                self.quantitySplit = 1
                self.quantityTextField.text = String(format: "%.0f", self.quantitySplit)
                self.resetView()
            }))
            self.present(showMessagePrompt, animated: true, completion: nil)
            
        } else {
            self.quantityTextField.text = String(format: "%.0f", quantitySplit)
        }
        
        resetView()
    }
    
}
