//
//  HalfViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 14/05/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class HalfViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var pizzasList = FoodMenu()
    var nameFirstHalf: String?
    var priceFirstHalf: Double?
    var pizzaName: String?
    var pizzaPrice: Double?
    var pizzaSize: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: "listCell")

    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        if let backVC = presentingViewController as? PizzasViewController {
            backVC.completeButton.sendActions(for: .touchUpInside)
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    //MARK: - tableView Delegate & Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzasList.pizzas.filter { $0.size == pizzaSize }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! FoodCell
        cell.title.text = pizzasList.pizzas.filter { $0.size == pizzaSize }[indexPath.row].name
        cell.descriptionLabel.text = pizzasList.pizzas.filter { $0.size == pizzaSize }[indexPath.row].description
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.backgroundColor = UIColor(named: "BrandLightBrow")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pizza = pizzasList.pizzas.filter { $0.size == pizzaSize }[indexPath.row]
        pizzaName = pizza.name
        pizzaPrice = Double(pizza.price) / 2
        
        if let backVC = presentingViewController as? PizzasViewController {
            if let pName = pizzaName, let pPrice = pizzaPrice {
                backVC.halfLabel.text = "Mitad: \(nameFirstHalf!) ($\(priceFirstHalf! / 2))\n Mitad: \(pName) ($\(pPrice))"
                backVC.halfPrice = Double(pPrice)
                backVC.halfName = pName
                backVC.viewDidLoad()
                
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
