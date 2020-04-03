//
//  AccountViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 09/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "Cuenta"
        self.parent?.navigationItem.rightBarButtonItem?.isEnabled = false
        self.parent?.navigationItem.rightBarButtonItem?.tintColor = .clear
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
