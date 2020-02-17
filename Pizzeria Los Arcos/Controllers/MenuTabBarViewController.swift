//
//  MenuTabBarViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 09/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class MenuTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9581161141, green: 0.8982322812, blue: 0.7349546552, alpha: 1)
    }
    

}
