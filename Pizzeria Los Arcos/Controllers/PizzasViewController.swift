//
//  PizzasViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox

class PizzasViewController: UIViewController {
    
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
    @IBOutlet weak var halfAndHalfButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var foodName: String?
    var foodType: String?
    
    var food = FoodMenu()
    var quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    
    var quantitySplit = 1
    var extraIngredientSplit = 0
    var oldValue: Double = 0
    
    var sizeCurrent = "Grande"
    var currentPrice: Double = 0.0
    var extraPrice: Double = 0.0
    var halfPrice: Double = 0.0
    var halfName: String?
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
        
        quantityPickerView.selectRow(Int(quantitySplit-1), inComponent: 0, animated: true)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        getTotal()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    func getTotal() {
        if halfPrice == 0 {
            currentPrice = (Double(food.getPizzaPrice(name: foodName!, size: sizeCurrent)) * Double(quantitySplit)) + extraPrice
        } else {
            currentPrice = (((Double(food.getPizzaPrice(name: foodName!, size: sizeCurrent)) / 2) + halfPrice) * Double(quantitySplit)) + extraPrice
        }
        
        totalLabel.text = "$\(String(currentPrice))"
    }
    
    func disableSizeButtons() {
        
        smallPctButton.isEnabled = false
        smallPctButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        mediumPctButton.isEnabled = false
        mediumPctButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        bigPctButton.isEnabled = false
        bigPctButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
    }
    
    func enableSizeButtons() {
        
        smallPctButton.isEnabled = true
        smallPctButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        mediumPctButton.isEnabled = true
        mediumPctButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        bigPctButton.isEnabled = true
        bigPctButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    func disableTypeButtons() {
        
        halfAndHalfButton.isEnabled = false
        halfAndHalfButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        completeButton.isEnabled = false
        completeButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
    }
    
    func enableTypeButtons() {
        
        halfAndHalfButton.isEnabled = true
        halfAndHalfButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        completeButton.isEnabled = true
        completeButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    func disableQuantityText() {
        
        quantityTextField.isEnabled = false
        quantityTextField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func enableQuantityText() {
        
        quantityTextField.isEnabled = true
        quantityTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    @IBAction func sizeChanged(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        smallPctButton.isSelected = false
        mediumPctButton.isSelected = false
        bigPctButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        sizeCurrent = sender.currentTitle!
        
        getTotal()
    }
    
    @IBAction func tipeChanged(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        halfAndHalfButton.isSelected = false
        completeButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        if sender.currentTitle == halfAndHalfButton.titleLabel?.text! {
            
            self.performSegue(withIdentifier: "PizzasToHalf", sender: self)
            
            disableSizeButtons()
            
            halfAndHalfButton.isEnabled = false
            
        } else if sender.currentTitle == completeButton.titleLabel?.text! {
            
            enableSizeButtons()
            
            halfAndHalfButton.isEnabled = true
            
            halfPrice = 0
            halfLabel.text = ""
            
        }
        
        getTotal()
        print(quantitySplit)
    }
    
    
    @IBAction func extraIngredientValueChangue(_ sender: UIStepper) {
        if (sender.value>oldValue) {
            oldValue += 1
            
            //Your Code You Wanted To Perform On Increment
            performSegue(withIdentifier: "PizzasToExtra", sender: self)
        }
        else {
            oldValue=oldValue-1
            
            //Your Code You Wanted To Perform On Decrement
            var lastExtra = ""
            for data in extraIngredients {
                lastExtra = data.key
            }
            extraIngredients.removeValue(forKey: lastExtra)
            extraIngredientLabel.text = ""
            extraPrice = 0
            for data in extraIngredients {
                extraIngredientLabel.text?.append("\(data.key)")
                extraPrice += Double(data.value)
            }
        }
        
        extraIngredientSplit = Int(sender.value)
        extraIngredientNumberLabel.text = String(extraIngredientSplit)
        
        getTotal()
        
        if (sender.value != 0) {
            disableSizeButtons()
            disableTypeButtons()
            disableQuantityText()
        } else {
            enableSizeButtons()
            enableTypeButtons()
            enableQuantityText()
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        if let half = halfName {
            OrdersList.ordersList.append(Orders(foodName: "Mitad: \(foodName!) - Mitad: \(half), \(sizeCurrent)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text))
        } else {
            OrdersList.ordersList.append(Orders(foodName: "\(foodName!), \(sizeCurrent)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
        }
        
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
        if segue.identifier == "PizzasToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.isModalInPresentation = true
            destinationVC.sizeCurrent = sizeCurrent
            destinationVC.quantity = quantitySplit
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "PizzasToHalf" {
            let destinationVC = segue.destination as! HalfTableViewController
            destinationVC.isModalInPresentation = true
            destinationVC.pizzaSize = sizeCurrent
        }
    }
    
}


//MARK: - PickerView Data Source

extension PizzasViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantity.count
    }
    
}


//MARK: - PickerView & TextField Delegates

extension PizzasViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(quantity[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        quantitySplit = quantity[row]
        
        quantityTextField.text = String(quantitySplit)
        
        getTotal()
    }
    
}
