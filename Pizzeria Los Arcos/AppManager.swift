//
//  AppManager.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 12/04/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
 
class AppManager {
    static let shared = AppManager()
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer: WelcomeViewController!
    private init() { }
    
    func showApp() {
        var viewController: UIViewController
        if Auth.auth().currentUser != nil {
            SVProgressHUD.show(withStatus: "Iniciando sesión")
            viewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            appContainer.navigationController?.pushViewController(viewController, animated: true)
            SVProgressHUD.dismiss()
        }
    }
    
}
