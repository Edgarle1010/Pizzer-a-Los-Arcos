//
//  BreakfastsEggs2ViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 06/05/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox
import BonsaiController

class BreakfastsEggs2ViewController: UIViewController {
    
    @IBOutlet weak var orderDetailsLabel: UILabel!
    @IBOutlet weak var halfOrderButton: UIButton!
    @IBOutlet weak var completeOrderButton: UIButton!
    @IBOutlet weak var section1: UILabel!
    @IBOutlet weak var option1Section1: UIButton!
    @IBOutlet weak var option2Section1: UIButton!
    @IBOutlet weak var section2: UILabel!
    @IBOutlet weak var option1Section2: UIButton!
    @IBOutlet weak var option2Section2: UIButton!
    @IBOutlet weak var option3Section2: UIButton!
    @IBOutlet weak var whiteBreadButton: UIButton!
    @IBOutlet weak var wholemealBreadButton: UIButton!
    @IBOutlet weak var baguetteButton: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var extraIngredientNumberLabel: UILabel!
    @IBOutlet weak var extraIngredientStepper: UIStepper!
    @IBOutlet weak var extraIngredientLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var option1Section2Constraint: NSLayoutConstraint!
    
    var bsection1: String?
    var boption1Section1: String?
    var boption2Section1: String?
    var bsection2: String?
    var boption1Section2: String?
    var boption2Section2: String?
    var boption3Section2: String?
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var foodName: String?
    var foodType: String?
    
    var food = FoodMenu()
    var quantity = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var quantitySplit = 1
    var oldValue: Double = 0
    
    var sizeCurrent = "Orden completa"
    var section1Current: String?
    var section2Current: String?
    var breadCurrent = "Baguette"
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
        
        loadStrings()
        
        getTotal()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    func loadStrings() {
        
        section1.text = bsection1
        option1Section1.setTitle(boption1Section1, for: .normal)
        option2Section1.setTitle(boption2Section1, for: .normal)
        section2.text = bsection2
        option1Section2.setTitle(boption1Section2, for: .normal)
        option2Section2.setTitle(boption2Section2, for: .normal)
        option3Section2.setTitle(boption3Section2, for: .normal)
        
        section1Current = boption2Section1
        section2Current = boption3Section2
        
        if foodName == "Huevos con chilaquiles" {
            option2Section2.removeFromSuperview()
            
            let newConstraint = option1Section2Constraint.constraintWithMultiplier(0.50)
            view.removeConstraint(option1Section2Constraint)
            view.addConstraint(newConstraint)
            view.layoutIfNeeded()
            option1Section2Constraint = newConstraint
        }
    }
    
    func getTotal() {
        
        if sizeCurrent == "Media orden" {
            currentPrice = ((Double(food.desayunos.filter{$0.name == foodName}[0].price) * 0.70) * Double(quantitySplit)) + Double(extraPrice)
        } else {
            currentPrice = (Double(food.desayunos.filter{$0.name == foodName}[0].price) * Double(quantitySplit)) + Double(extraPrice)
        }
        
        totalLabel.text = "$\(String(format: "%.2f", currentPrice))"
    }
    
    func disableOptions() {
        
        halfOrderButton.isEnabled = false
        halfOrderButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        completeOrderButton.isEnabled = false
        completeOrderButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        option1Section1.isEnabled = false
        option1Section1.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        option2Section1.isEnabled = false
        option2Section1.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        option1Section2.isEnabled = false
        option1Section2.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        if foodName != "Huevos con chilaquiles" {
            option2Section2.isEnabled = false
            option2Section2.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        }
        option3Section2.isEnabled = false
        option3Section2.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        quantityTextField.isEnabled = false
        quantityTextField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func enableOptions() {
        
        halfOrderButton.isEnabled = true
        halfOrderButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        completeOrderButton.isEnabled = true
        completeOrderButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        option1Section1.isEnabled = true
        option1Section1.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        option2Section1.isEnabled = true
        option2Section1.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        option1Section2.isEnabled = true
        option1Section2.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        if foodName != "Huevos con chilaquiles" {
            option2Section2.isEnabled = true
            option2Section2.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        }
        option3Section2.isEnabled = true
        option3Section2.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
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
    
    @IBAction func section1Changed(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        option1Section1.isSelected = false
        option2Section1.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        section1Current = sender.currentTitle!
    }
    
    @IBAction func section2Changed(_ sender: UIButton) {
        
        //Diselect all size buttons via IBOutlets
        option1Section2.isSelected = false
        if foodName != "Huevos con chilaquiles" {
            option2Section2.isSelected = false
        }
        option3Section2.isSelected = false
        
        //Make the button that triggered the IBAction selected.
        sender.isSelected = true
        
        //Get the current title of the button that was pressed.
        section2Current = sender.currentTitle!
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
            performSegue(withIdentifier: "BreakfastsEggs2ToExtra", sender: self)
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
        
        guard let section1 = section1Current, let section2 = section2Current else { fatalError() }
        
        OrdersList.ordersList.append(Orders(foodName: "\(sizeCurrent): \(foodName!), \(section1), \(section2), Pan \(breadCurrent)", quantity: Int(quantitySplit), extraIngredient: extraIngredients, price: currentPrice, comments: commentsTextView.text!))
        
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
        if segue.identifier == "BreakfastsEggs2ToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.isModalInPresentation = true
            destinationVC.sizeCurrent = sizeCurrent
            destinationVC.quantity = quantitySplit
            destinationVC.foodType = foodType
            
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
}


//MARK: - PickerView Data Source

extension BreakfastsEggs2ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quantity.count
    }
    
}


//MARK: - PickerView & TextField Delegates

extension BreakfastsEggs2ViewController: UIPickerViewDelegate, UITextFieldDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(quantity[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        quantitySplit = quantity[row]
        quantityTextField.text = String(quantitySplit)
        
        getTotal()
    }
    
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}


//MARK: - Bonsai Framework
extension BreakfastsEggs2ViewController: BonsaiControllerDelegate {
    
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



