//
//  MenuViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 04/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var foodType: String?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "Menú"
        self.parent?.navigationItem.rightBarButtonItem?.isEnabled = false
        self.parent?.navigationItem.rightBarButtonItem?.tintColor = .clear
        
    }
    
    @IBAction func imagenPressed(_ sender: UIButton) {
        //Navigate to the FoodViewController
        foodType = sender.currentTitle
        performSegue(withIdentifier: "MenuToFoodList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuToFoodList" {
            let destinationVC = segue.destination as! FoodViewController
            destinationVC.foodType = foodType
        }
    }
    
}
