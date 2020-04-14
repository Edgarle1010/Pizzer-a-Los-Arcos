//
//  WelcomeViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 09/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppManager.shared.appContainer = self
        AppManager.shared.showApp()
    }
    
    @IBAction func guestButtonPressed(_ sender: UIButton) {
        
        var viewController: UIViewController
        viewController = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MenuTabBarViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
        let showMessagePrompt = UIAlertController(title: "Has iniciado sesión como invitado", message: "Podrás ver el menú y usar sus funciones pero no te será posible realizar pedidos.", preferredStyle: .alert)
        showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
            NSLog("Guest user login.")
        }))
        self.present(showMessagePrompt, animated: true, completion: nil)
        
    }
    

}
