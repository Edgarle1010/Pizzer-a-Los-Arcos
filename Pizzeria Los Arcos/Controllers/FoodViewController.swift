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
    var foodName: String?
    var foodType: String?
    var food = FoodMenu()
    
    var foodData: [Food] = [] //Super class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch foodType {
        case "Pizzas":
            foodData = food.pizzas.filter { $0.size == "Grande" }
        case "Hamburguesas":
            foodData = food.hamburguesas
        case "Ensaladas":
            foodData = food.ensaladas
        case "Platillos":
            foodData = food.platillos
        case "Mariscos":
            foodData = food.mariscos
        case "Desayunos":
            foodData = food.desayunos
        case "Bebidas":
            foodData = food.bebidas
        case "Postres":
            foodData = food.postres
        case "Nieves":
            foodData = food.nieves
        case "Kids":
            foodData = food.kids
        default: break
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: "listCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = foodType
    }
    
}

extension FoodViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! FoodCell
        cell.title.text = foodData[indexPath.row].name
        cell.descriptionLabel.text = foodData[indexPath.row].description
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.backgroundColor = UIColor(named: "BrandLightBrow")
        cell.selectionStyle = .none
        return cell
    }


}

extension FoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        foodName = foodData[indexPath.row].name
        switch foodType {
        case "Pizzas":
            performSegue(withIdentifier: "MenuToPreOrder", sender: self)
        case "Bebidas", "Postres", "Nieves":
            performSegue(withIdentifier: "MenuToOrderThird", sender: self)
        default:
            performSegue(withIdentifier: "MenuToPreOrderSecond", sender: self)
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuToPreOrder" {
            let destinationVC = segue.destination as! BeforeOrderViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "MenuToPreOrderSecond" {
            let destinationVC = segue.destination as! BeforeOrderSecondViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "MenuToOrderThird" {
            let destinationVC = segue.destination as! BeforeOrderThirdViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
    }
    
}
