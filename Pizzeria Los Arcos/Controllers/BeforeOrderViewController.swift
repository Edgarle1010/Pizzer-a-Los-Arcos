//
//  BeforeOrderViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class BeforeOrderViewController: UIViewController {
    
    @IBOutlet weak var smallPctButton: UIButton!
    @IBOutlet weak var mediumPctButton: UIButton!
    @IBOutlet weak var bigPctButton: UIButton!
    @IBOutlet weak var quantityNumberLabel: UILabel!
    @IBOutlet weak var extraIngredientNumberLabel: UILabel!
    @IBOutlet weak var extraIngredientLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var extraIngredientStepper: UIStepper!
    
    
    var pizzasList = PizzasList()
    
    var quantitySplit = 1
    var extraIngredientSplit = 0
    var oldValue: Double = 0
    
    var sizeCurrent = "Grande"
    var pizzaName: String?
    var currentPrice = 0
    var extraPrice = 0
    var extraIngredients = [String:Int]()
    var lastExtra = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTotal()
    }
    
    func getTotal() {
        currentPrice = (pizzasList.getPizzaPrice(name: pizzaName!, size: sizeCurrent) + extraPrice) * quantitySplit
        totalLabel.text = "$\(String(currentPrice))"
    }
    
    func resetView() {
        extraPrice = 0
        extraIngredientLabel.text = ""
        extraIngredients.removeAll()
//        quantityStepper.value = 1
        extraIngredientStepper.value = 0
//        quantitySplit = 1
//        quantityNumberLabel.text = "1"
        extraIngredientSplit = 0
        extraIngredientNumberLabel.text = "0"
        oldValue = 0
        
        getTotal()
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
        
        resetView()
    }
    
    @IBAction func quantityValueChanged(_ sender: UIStepper) {
        
        quantitySplit = Int(sender.value)
        quantityNumberLabel.text = String(quantitySplit)
        
        resetView()
    }
    
    @IBAction func extraIngredientValueChangue(_ sender: UIStepper) {
        if (sender.value>oldValue) {
            oldValue += 1
            //Your Code You Wanted To Perform On Increment
            performSegue(withIdentifier: "ProOrderToExtra", sender: self)
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
            quantityStepper.isEnabled = false
            smallPctButton.isEnabled = false
            smallPctButton.isHighlighted = true
            mediumPctButton.isEnabled = false
            mediumPctButton.isHighlighted = true
            bigPctButton.isEnabled = false
            bigPctButton.isHighlighted = true
        } else {
            quantityStepper.isEnabled = true
            smallPctButton.isEnabled = true
            smallPctButton.isHighlighted = false
            mediumPctButton.isEnabled = true
            mediumPctButton.isHighlighted = false
            bigPctButton.isEnabled = true
            bigPctButton.isHighlighted = false
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProOrderToExtra" {
            let destinationVC = segue.destination as! ExtraIngredientViewController
            destinationVC.isModalInPresentation = true
            destinationVC.sizeCurrent = sizeCurrent
            destinationVC.quantity = quantitySplit
        }
    }
    
}
