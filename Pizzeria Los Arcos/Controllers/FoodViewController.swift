//
//  FoodViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var pizzasList = PizzasList()
    var pizzaName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: "listCell")
    }
    
}

extension FoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzasList.pizzas.filter { $0.size == "Grande" }.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! FoodCell
        cell.title.text = pizzasList.pizzas.filter { $0.size == "Grande" }[indexPath.row].name
        cell.descriptionLabel.text = pizzasList.pizzas.filter { $0.size == "Grande" }[indexPath.row].description
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.backgroundColor = UIColor(named: "BrandLightBrow")
        cell.selectionStyle = .none
        return cell
    }


}

extension FoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pizzaName = pizzasList.pizzas.filter { $0.size == "Grande" }[indexPath.row].name
        performSegue(withIdentifier: "MenuToPreOrder", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuToPreOrder" {
            let destinationVC = segue.destination as! BeforeOrderViewController
            destinationVC.pizzaName = pizzaName
        }
    }
    
}
