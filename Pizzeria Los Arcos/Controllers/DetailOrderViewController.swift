//
//  DetailOrderViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 13/04/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class DetailOrderViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let db = Firestore.firestore()
    
    var orderList: [Orders] = []
    var orderID: String?
    var totalPrice: Double = 0.0
    var buttonIsHidden: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ListOrderCell", bundle: nil), forCellReuseIdentifier: "listOrderCell")
        
        tableView.tableFooterView = UIView()
        
        loadOrderList()

    }
    
    func loadOrderList() {
        
        if let order = orderID {
            SVProgressHUD.show()
            let docRef = db.collection("orders").document(order)
            
            docRef.getDocument { (document, error) in
                
                SVProgressHUD.dismiss()
            
                self.orderList = []
                
                if let document = document, document.exists {
                    let numberOfOrder = document.data()!["numberOfOrders"] as! Int
                    for index in 1...numberOfOrder {
                        let docData = document.data()!["\(index)"] as! [String: AnyObject]
                        self.orderList.append(Orders(
                            foodName: docData["foodName"] as!String,
                            quantity: docData["quantity"] as! Int,
                            extraIngredient: docData["extraIngredient"] as! [String : Int],
                            price: docData["price"] as! Double,
                            comments: docData["comments"] as! String))
                        
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        for data in self.orderList {
                            self.totalPrice += data.price
                        }
                        self.totalLabel.text = "$\(self.totalPrice)"
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listOrderCell", for: indexPath) as! ListOrderCell
        cell.titleLabel.text = orderList[indexPath.row].foodName
        cell.quantityLabel.text = String(orderList[indexPath.row].quantity)
        cell.extraIngredientLabel.text?.removeAll()
        for data in orderList[indexPath.row].extraIngredient {
            cell.extraIngredientLabel.text?.append("\(data.key)")
        }
        cell.commentsLabel.text = orderList[indexPath.row].comments
        cell.priceLabel.text = "$\(orderList[indexPath.row].price)"
        
        return cell
    }

}
