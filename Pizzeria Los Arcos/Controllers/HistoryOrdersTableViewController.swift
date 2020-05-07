//
//  HistoryOrdersTableViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 13/04/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class HistoryOrdersTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var orders: [OrderHistory] = []
    var orderID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "orderCell")
        
        tableView.tableFooterView = UIView()
        
        loadOrders()
        
    }
    
    func loadOrders() {
        
        SVProgressHUD.show()
        
        if let client = Auth.auth().currentUser?.phoneNumber {
            db.collection("orders").whereField("client", isEqualTo: client)
                .getDocuments { (querySnapshot, error) in
                    
                    self.orders = []
                    
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    
                    self.tableView.reloadData()
                    
                    for doc in documents {
                        let data = doc.data()
                        if let clientID = data["client"] as? String, let clientName = data["clientName"] as? String, let orderID = doc.documentID as? String, let date = data["date"] as? Double {
                            let newOrder = OrderHistory(clientID: clientID, clientName: clientName, orderID: orderID, date: date)
                            self.orders.append(newOrder)
                            self.orders = self.orders.sorted(by: { $0.date < $1.date })
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
            }
            SVProgressHUD.dismiss()
        } else {
            let showMessagePrompt = UIAlertController(title: "Has iniciado sesión como invitado", message: "No tienes historial de pedidos", preferredStyle: .alert)
            showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                NSLog("Guest user login.")
            }))
            self.present(showMessagePrompt, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.backgroundColor = UIColor(named: "BrandLightBrow")
        cell.selectionStyle = .none
        
        cell.clientIDLabel.text = orders[indexPath.row].clientID
        cell.clientNameLabel.text = orders[indexPath.row].clientName
        cell.orderIDLabel.text = orders[indexPath.row].orderID
        let timestamp = orders[indexPath.row].date
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.dateLabel.text = "\(dateFormatter.string(from: time as Date))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderID = orders[indexPath.row].orderID
        performSegue(withIdentifier: "HistoryToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryToDetail" {
            let destinationVC = segue.destination as! DetailOrderViewController
            destinationVC.orderID = orderID
        }
    }
    
}
