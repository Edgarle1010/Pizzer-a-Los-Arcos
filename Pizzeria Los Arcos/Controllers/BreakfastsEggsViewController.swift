//
//  BreakfastsEggsViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 04/05/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox
import BonsaiController

class BreakfastsEggsViewController: UIViewController {
    
    @IBOutlet weak var orderDetailsLabel: UILabel!
    @IBOutlet weak var halfOrderButton: UIButton!
    @IBOutlet weak var completeOrderButton: UIButton!
    @IBOutlet weak var scrambledStyleButton: UIButton!
    @IBOutlet weak var scrambledIngredientLabel: UILabel!
    @IBOutlet weak var starryStyleButton: UIButton!
    @IBOutlet weak var whiteBreadButton: UIButton!
    @IBOutlet weak var baguetteButton: UIButton!
    @IBOutlet weak var wholemealBreadButton: UIButton!
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
    
    var quantitySplit = 1
    var oldValue: Double = 0
    
    var sizeCurrent = "Orden completa"
    var styleCurrent = "Estrellados"
    var breadCurrent = "Baguette"
    var currentPrice: Double = 0
    var extraPrice: Double = 0
    var scrambledIngredient: String?
    var scrambledIngredientPrice: Int = 0
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
        
        if sizeCurrent == "Media orden" {
            currentPrice = (((Double(food.desayunos.filter{$0.name == foodName}[0].price) * 0.70) + Double(scrambledIngredientPrice)) * Double(quantitySplit)) + Double(extraPrice)
        } else {
            currentPrice = (Double(food.desayunos.filter{$0.name == foodName}[0].price + scrambledIngredientPrice) * Double(quantitySplit)) + Double(extraPrice)
        }
        
        totalLabel.text = "$\(String(format: "%.2f", currentPrice))"
    }
    
    func disableOptions() {
        
        halfOrderButton.isEnabled = false
        halfOrderButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        completeOrderButton.isEnabled = false
        completeOrderButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        scrambledStyleButton.isEnabled = false
        scrambledStyleButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        starryStyleButton.isEnabled = false
        starryStyleButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        quantityTextField.isEnabled = false
        quantityTextField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func enableOptions() {
        
        halfOrderButton.isEnabled = true
        halfOrderButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        completeOrderButton.isEnabled = true
        completeOrderButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        scrambledStyleButton.isEnabled = true
        scrambledStyleButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        starryStyleButton.isEnabled = true
        starryStyleButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        quantityTextField.isEnabled = true
        quantityTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
    
    @IBAction func styleChanged(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        scrambledStyleButton.isSelected = false
        starryStyleButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        
        if sender.currentTitle == scrambledStyleButton.titleLabel?.text {
            scrambledStyleButton.isEnabled = false
            performSegue(withIdentifier: "EggsToScrambledEggs", sender: self)
            
        } else if sender.currentTitle == starryStyleButton.titleLabel?.text! {
            scrambledStyleButton.isEnabled = true
            scrambledIngredientLabel.text = ""
            scrambledIngredient = scrambledIngredientLabel.text
            scrambledIngredientPrice = 0
        }
        
        styleCurrent = sender.currentTitle!
        
        getTotal()
        
    }
    
    @IBAction func breadChange(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        whiteBreadButton.isSelected = false
        wholemealBreadButton.isSelected = false
        baguetteButton.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        breadCurrent = sender.currentTitle!
        
        getTotal()
    }
    
    @IBAction func extraIngredientValueChanged(_ sender: UIStepper) {
        
        if (sender.value>oldValue) {
            oldValue += 1
            //Your Code You Wanted To Perform On Increment
            performSegue(withIdentifier: "BreakfastsEggsToExtra", sender: self)
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
            disableOptions()
        } else {
            enableOptions()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        OrdersList.ordersList.append(Orders(foodName: "\(sizeCurrent): \(foodName!), \(styleCurrent), \(scrambledIngredient ?? ""), Pan \(breadCurrent)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
        
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
        if segue.identifier == "BreakfastsEggsToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.sizeCurrent = sizeCurrent
            destinationVC.quantity = quantitySplit
            destinationVC.foodType = foodType
            
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
        
        if segue.identifier == "EggsToScrambledEggs" {
            let destinationVC = segue.destination as! ScrambledEggsViewController
            destinationVC.isModalInPresentation = true
        }
    }
    
}


//MARK: - PickerView Data Source

extension BreakfastsEggsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantity.count
    }
    
}


//MARK: - PickerView & TextField Delegates

extension BreakfastsEggsViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
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
extension BreakfastsEggsViewController: BonsaiControllerDelegate {
    
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



