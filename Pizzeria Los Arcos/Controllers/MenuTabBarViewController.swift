//
//  MenuTabBarViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 09/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class MenuTabBarViewController: UITabBarController, UITabBarControllerDelegate, ModalTransitionListener {
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                OrdersList.ordersList = try decoder.decode([Orders].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
            
        }
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9581161141, green: 0.8982322812, blue: 0.7349546552, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ModalTransitionMediator.instance.setListener(listener: self)
        syncBadge()
    }
    
    func popoverDismissed() {
        syncBadge()
    }
    
    func syncBadge() {
        let notificationButton = SSBadgeButton()
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(systemName: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        notificationButton.badge = String(OrdersList.ordersList.count)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        
        notificationButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(notificationButton)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        performSegue(withIdentifier: "RootToShoppingCar", sender: self)
    }
    
}
