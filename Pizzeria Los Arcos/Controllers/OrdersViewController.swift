//
//  OrdersViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import AudioToolbox

class OrdersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ListOrderCell", bundle: nil), forCellReuseIdentifier: "listOrderCell")
        
        tableView.tableFooterView = UIView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        
        self.parent?.navigationItem.title = "Lista de Pedido"
        self.parent?.navigationItem.rightBarButtonItem?.isEnabled = true
        self.parent?.navigationItem.rightBarButtonItem?.tintColor = .black
        
        getTotal()
        
    }
    
    func getTotal() {
        var total: Double = 0.0
        for data in OrdersList.ordersList {
            total += data.price
        }
        
        totalLabel.text = "$\(total)"
        
        self.tabBarController?.tabBar.items?[1].badgeValue = String(OrdersList.ordersList.count)
    }
    
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        OrdersList.ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listOrderCell", for: indexPath) as! ListOrderCell
        cell.titleLabel.text = OrdersList.ordersList[indexPath.row].foodName
        cell.quantityLabel.text = String(OrdersList.ordersList[indexPath.row].quantity)
        
        cell.extraIngredientLabel.text?.removeAll()
        for data in OrdersList.ordersList[indexPath.row].extraIngredient {
            cell.extraIngredientLabel.text?.append("\(data.key)")
        }
        
        cell.commentsLabel.text = OrdersList.ordersList[indexPath.row].comments
        cell.priceLabel.text = "$\(OrdersList.ordersList[indexPath.row].price)"
        
        return cell
    }
    
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            OrdersList.ordersList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate) {
            }
            getTotal()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
