//
//  FoodViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, ModalTransitionListener {
    
    @IBOutlet weak var tableView: UITableView!
    
    var foodName: String?
    var foodType: String?
    var food = FoodMenu()
    
    var foodData: [Food] = [] //Super class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModalTransitionMediator.instance.setListener(listener: self)
        
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
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = foodType
        
        syncBadge()
    }
    
    func popoverDismissed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        syncBadge()
    }
    
    func syncBadge() {
        let notificationButton = SSBadgeButton()
        notificationButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        notificationButton.setImage(UIImage(systemName: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        notificationButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        notificationButton.badge = String(OrdersList.ordersList.count)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
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
        let description = foodData[indexPath.row].description
        foodName = foodData[indexPath.row].name
        switch foodType {
        case "Pizzas":
            performSegue(withIdentifier: "MenuToPizzas", sender: self)
        case "Hamburguesas", "Ensaladas", "Platillos", "Mariscos":
            performSegue(withIdentifier: "MenuToBurguer", sender: self)
        case "Desayunos":
            if foodName == K.Desayunos.HuevosChilaquiles.name || foodName == K.Desayunos.Montadas.name || foodName == K.Desayunos.Huevos.name {
                performSegue(withIdentifier: "MenuToBreakfastsEggs2", sender: self)
            } else if description.contains("revueltos o estrellados") {
                performSegue(withIdentifier: "MenuToBreakfastsEggs", sender: self)
            } else {
                performSegue(withIdentifier: "MenuToBreakfasts", sender: self)
            }
        case "Bebidas", "Postres", "Nieves":
            performSegue(withIdentifier: "MenuToOrderThird", sender: self)
        case "Kids":
            performSegue(withIdentifier: "MenuToKids", sender: self)
        default:
            performSegue(withIdentifier: "MenuToPreOrderSecond", sender: self)
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuToPizzas" {
            let destinationVC = segue.destination as! PizzasViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "MenuToBurguer" {
            let destinationVC = segue.destination as! BurgerViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "MenuToBreakfasts" {
            let destinationVC = segue.destination as! BreakfastsViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "MenuToBreakfastsEggs" {
            let destinationVC = segue.destination as! BreakfastsEggsViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "MenuToBreakfastsEggs2" {
            let destinationVC = segue.destination as! BreakfastsEggs2ViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
            
            if foodName == K.Desayunos.HuevosChilaquiles.name {
                destinationVC.bsection1 = "Estilo"
                destinationVC.boption1Section1 = "Revueltos"
                destinationVC.boption2Section1 = "Estrellados"
                destinationVC.bsection2 = "Chilaquiles"
                destinationVC.boption1Section2 = "Rojos"
                destinationVC.boption2Section2 = ""
                destinationVC.boption3Section2 = "Verdes"
                
            } else if foodName == K.Desayunos.Montadas.name {
                destinationVC.bsection1 = "Enchiladas"
                destinationVC.boption1Section1 = "Rojas"
                destinationVC.boption2Section1 = "Verdes"
                destinationVC.bsection2 = "Ingrediente"
                destinationVC.boption1Section2 = "Queso"
                destinationVC.boption2Section2 = "Picadillo"
                destinationVC.boption3Section2 = "Pollo"
                
            } else if foodName == K.Desayunos.Huevos.name {
                destinationVC.bsection1 = "Estilo"
                destinationVC.boption1Section1 = "Revueltos"
                destinationVC.boption2Section1 = "Estrellados"
                destinationVC.bsection2 = "Ingrediente"
                destinationVC.boption1Section2 = "Tocino"
                destinationVC.boption2Section2 = "Jamón"
                destinationVC.boption3Section2 = "Chorizo"
            }
        }
        
        if segue.identifier == "MenuToOrderThird" {
            let destinationVC = segue.destination as! BeforeOrderThirdViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
        
        if segue.identifier == "MenuToKids" {
            let destinationVC = segue.destination as! KidsViewController
            destinationVC.foodName = foodName
            destinationVC.foodType = foodType
        }
    }
    
}
