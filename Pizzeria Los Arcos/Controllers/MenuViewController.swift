//
//  MenuViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 04/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func imagenPressed(_ sender: UIButton) {
        //Navigate to the FoodViewController
        performSegue(withIdentifier: "MenuToFoodList", sender: self)
    }
}
