//
//  HalfTableViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 17/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class HalfTableViewController: UITableViewController {
    
    var pizzasList = FoodMenu()
    var pizzaName = ""
    var pizzaPrice: Double = 0.0
    var pizzaSize: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: "listCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let showMessagePrompt = UIAlertController(title: nil, message: "Selecciona la otra mitad", preferredStyle: .alert)
        showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
        }))
        self.present(showMessagePrompt, animated: true, completion: nil)
    }
    
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! FoodCell
        cell.title.text = pizzasList.pizzas.filter { $0.size == pizzaSize }[indexPath.row].name
        cell.descriptionLabel.text = pizzasList.pizzas.filter { $0.size == pizzaSize }[indexPath.row].description
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.backgroundColor = UIColor(named: "BrandLightBrow")
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzasList.pizzas.filter { $0.size == pizzaSize }.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pizza = pizzasList.pizzas.filter { $0.size == pizzaSize }[indexPath.row]
        pizzaName = pizza.name
        pizzaPrice = Double(pizza.price) / 2
        
        if let backVC = presentingViewController as? BeforeOrderViewController {
            backVC.halfLabel.text = "Mitad: \(pizzaName) ($\(pizzaPrice))"
            backVC.halfPrice = Double(pizzaPrice)
            backVC.quantitySplit = 1
            backVC.halfName = pizzaName
            backVC.viewDidLoad()
            
            dismiss(animated: true, completion: nil)
        }
    }

}
