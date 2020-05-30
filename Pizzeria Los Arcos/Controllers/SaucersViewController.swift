//
//  SaucersViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 08/05/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox
import BonsaiController

class SaucersViewController: UIViewController {

    @IBOutlet weak var orderDetailsLabel: UILabel!
    @IBOutlet weak var hastButton: UIButton!
    @IBOutlet weak var chickenButton: UIButton!
    @IBOutlet weak var cheeseButton: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var extraIngredientNumberLabel: UILabel!
    @IBOutlet weak var extraIngredientStepper: UIStepper!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var extraIngredientLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var foodName: String?
    var foodType: String?
    
    var food = FoodMenu()
    var quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var quantitySplit = 1
    var oldValue: Double = 0
    
    var ingredientCurrent = "Queso"
    var currentPrice: Double = 0
    var extraPrice: Double = 0
    var extraIngredients = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderDetailsLabel.text = foodName!
        
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
        
        currentPrice = (Double(food.platillos.filter{$0.name == foodName}[0].price) * Double(quantitySplit)) + Double(extraPrice)
        
        totalLabel.text = "$\(String(format: "%.2f", currentPrice))"
    }
    
    @IBAction func ingredientChanged(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        hastButton.isSelected = false
        chickenButton.isSelected = false
        cheeseButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        ingredientCurrent = sender.currentTitle!
        
        getTotal()
        
    }
    
    @IBAction func extraIngredientValueChange(_ sender: UIStepper) {
        
        if (sender.value>oldValue) {
            oldValue += 1
            //Your Code You Wanted To Perform On Increment
            performSegue(withIdentifier: "SaucersToExtra", sender: self)
        } else if (sender.value<oldValue) {
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
        
        extraIngredientNumberLabel.text = String(Int(sender.value))
        
        getTotal()
        
        if (sender.value != 0) {
            hastButton.isEnabled = false
            hastButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            chickenButton.isEnabled = false
            chickenButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            cheeseButton.isEnabled = false
            cheeseButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
            quantityTextField.isEnabled = false
            quantityTextField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            hastButton.isEnabled = true
            hastButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            chickenButton.isEnabled = true
            chickenButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            cheeseButton.isEnabled = true
            cheeseButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            quantityTextField.isEnabled = true
            quantityTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        OrdersList.ordersList.append(Orders(foodName: "\(foodName!), \(ingredientCurrent)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
        
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
        if segue.identifier == "SaucersToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.sizeCurrent = ingredientCurrent
            destinationVC.quantity = quantitySplit
            destinationVC.foodType = foodType
            destinationVC.foodName = foodName
            
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
}


//MARK: - PickerView Data Source

extension SaucersViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantity.count
    }
    
}


//MARK: - PickerView & TextField Delegates

extension SaucersViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(quantity[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        quantitySplit = quantity[row]
        quantityTextField.text = String(quantitySplit)
        
        getTotal()
    }
    
}


//MARK: - Bonsai Framework
extension SaucersViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 2), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / 2))
    }
    
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    
        /// With Background Color ///
    
        // Slide animation from .left, .right, .top, .bottom
        let bonsaiController = BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
        
        bonsaiController.isDisabledTapOutside = true
        
        return bonsaiController
        
        
        // or Bubble animation initiated from a view
        //return BonsaiController(fromView: yourOriginView, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
    
    
        /// With Blur Style ///
        
        // Slide animation from .left, .right, .top, .bottom
        //return BonsaiController(fromDirection: .bottom, blurEffectStyle: .light, presentedViewController: presented, delegate: self)
        
        // or Bubble animation initiated from a view
        //return BonsaiController(fromView: yourOriginView, blurEffectStyle: .dark,  presentedViewController: presented, delegate: self)
    }
}


