//
//  OrdersViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import AudioToolbox
import CoreLocation
import SVProgressHUD
import Toast_Swift

class OrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let db = Firestore.firestore()
    let locationManager = CLLocationManager()
    var currentLocation: String?
    var messageService: String?
    var currentWaitTime: String?
    
    typealias banedStatusClouser = (Bool?) -> Void
    typealias serviceStatusClouser = (Bool?) -> Void
    typealias waitTimeClouser = (String?) -> Void
    typealias idClouser = (Int?) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.makeToast("Desliza hacia la izquierda cualquier producto si deseas eliminarlo.", duration: 2.0, position: .center)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ListOrderCell", bundle: nil), forCellReuseIdentifier: "listOrderCell")
        
        tableView.tableFooterView = UIView()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
        
        getTotal()
    }
    
    func getTotal() {
        var total: Double = 0.0
        for data in OrdersList.ordersList {
            total += data.price
        }
        
        totalLabel.text = "$\(total)"
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        
        if OrdersList.ordersList.count != 0 {
            loadWaitTime { (waitTime) in
                let showMessagePrompt = UIAlertController(title: "¿Seguro que quieres realizar el pedido?", message: "Tiempo de espera promedio: \(waitTime!) minutos", preferredStyle: .alert)
                showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Defalut action"), style: .default, handler: { (_) in
                    
                    self.locationManager.requestLocation()
                    
                    if let client = Auth.auth().currentUser?.phoneNumber, let clientName = Auth.auth().currentUser?.displayName {
                        
                        self.checkBaned(documentID: client) { (bool) in
                            if bool == false {
                                self.checkService { (bool) in
                                    if bool == true {
                                        var docData: [String: Any] = [
                                            "client": client,
                                            "clientName": clientName,
                                            "date": Date().timeIntervalSince1970,
                                            "location": self.currentLocation ?? "No proporcionada",
                                            "complete": false,
                                            "numberOfOrders": OrdersList.ordersList.count
                                        ]
                                        var i = 1
                                        for data in OrdersList.ordersList {
                                            docData["\(i)"] = [
                                                "foodName": data.foodName,
                                                "quantity": data.quantity,
                                                "extraIngredient": data.extraIngredient,
                                                "price": data.price,
                                                "comments": data.comments
                                            ]
                                            i += 1
                                        }
                                        self.getID { (id) in
                                            SVProgressHUD.show()
                                            self.db.collection("orders").document("\(id!)").setData(docData) { (error) in
                                                SVProgressHUD.dismiss()
                                                if let error = error {
                                                    self.alert(title: "¡Ha ocurrido un problema al enviar el pedido!", message: "\(error)")
                                                } else {
                                                    AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate) {
                                                    }
                                                    
                                                    let alert = UIAlertController(title: "¡Pedido enviado correctamente!", message: "Puedes pasar por él en \(waitTime!) minutos.\nRecuerda pasar por tu pedido a Pizzería Los Arcos Gómez Morin", preferredStyle: UIAlertController.Style.alert)
                                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                                        self.dismiss(animated: true, completion: nil)
                                                    }))
                                                    self.present(alert, animated: true, completion: nil)
                                                    OrdersList.ordersList.removeAll()
                                                    
                                                    let encoder = PropertyListEncoder()
                                                    
                                                    do {
                                                        let data = try encoder.encode(OrdersList.ordersList)
                                                        try data.write(to: self.dataFilePath!)
                                                    } catch {
                                                        print("Error encoding item array, \(error)")
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        if let message = self.messageService {
                                            AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate) {
                                            }
                                            let alert = UIAlertController(title: "¡Aviso!", message: message, preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                            self.present(alert, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                }
                                
                            } else {
                                AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate) {
                                }
                                let alert = UIAlertController(title: "¡Ha ocurrido un problema!", message: "Tu cuenta ha sido limitada para hacer pedidos por el uso incorrecto de la servicio. Comunicate a soporte si deseas revisar tu caso", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                return
                            }
                        }
                    } else {
                        let showMessagePrompt = UIAlertController(title: "Has iniciado sesión como invitado", message: "Para poder relizar tu pedido es necesario que te registres, reabre la App y completa el proceso de registro o inicia sesión en caso de ya tener una cuenta.", preferredStyle: .alert)
                        showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                            NSLog("Guest user try to order")
                        }))
                        self.present(showMessagePrompt, animated: true, completion: nil)
                    }
                }))
                showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (_) in
                    return
                }))
                self.present(showMessagePrompt, animated: true, completion: nil)
            }
        } else {
            self.alert(title: nil, message: "La lista esta vacía")
        }
    }
    
    func alert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func loadWaitTime(completionHandler:@escaping waitTimeClouser) {
        SVProgressHUD.show()
        db.collection("waitTime").document("time")
            .getDocument(source: .server) { documentSnapshot, error in
                SVProgressHUD.dismiss()
                var waitTime: String?
                
                guard let document = documentSnapshot else {
                    let alert = UIAlertController(title: "¡Ha ocurrido un error!", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                if let time = data["time"] as? String {
                    waitTime = time
                }
                
                DispatchQueue.main.async {
                    completionHandler(waitTime)
                }
        }
    }
    
    func checkBaned(documentID: String, completionHandler:@escaping banedStatusClouser) {
        SVProgressHUD.show()
        db.collection("users").document(documentID)
            .getDocument(source: .server) { documentSnapshot, error in
                SVProgressHUD.dismiss()
                var banedStatus: Bool?
                
                guard let document = documentSnapshot else {
                    let alert = UIAlertController(title: "¡Ha ocurrido un error!", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                if let baned = data["baned"] as? Bool {
                    banedStatus = baned
                }
                
                DispatchQueue.main.async {
                    completionHandler(banedStatus)
                }
        }
    }
    
    func checkService(completionHandler:@escaping serviceStatusClouser) {
        SVProgressHUD.show()
        db.collection("messages").document("current")
            .getDocument(source: .server) { documentSnapshot, error in
                SVProgressHUD.dismiss()
                var serviceStatus: Bool?
                
                guard let document = documentSnapshot else {
                    let alert = UIAlertController(title: "¡Ha ocurrido un error!", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                if let status = data["status"] as? Bool, let message = data["message"] as? String {
                    serviceStatus = status
                    self.messageService = message
                }
                
                DispatchQueue.main.async {
                    completionHandler(serviceStatus)
                }
        }
    }
    
    func getID(completionHandler:@escaping idClouser) {
        SVProgressHUD.show()
        db.collection("data").document("stats")
            .getDocument(source: .server) { documentSnapshot, error in
                SVProgressHUD.dismiss()
                var id: Int?
                
                guard let document = documentSnapshot else {
                    let alert = UIAlertController(title: "¡Ha ocurrido un error!", message: error!.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                if let currentID = data["id"] as? Int {
                    id = currentID
                }
                
                DispatchQueue.main.async {
                    completionHandler(id)
                    
                    let idRef = self.db.collection("data").document("stats")
                    
                    idRef.updateData([
                        "id": FieldValue.increment(Int64(1))
                    ])
                }
        }
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
            
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(OrdersList.ordersList)
                try data.write(to: self.dataFilePath!)
            } catch {
                print("Error encoding item array, \(error)")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate) {
            }
            getTotal()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}


extension OrdersViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            currentLocation = "latitude = \(lat), longitude = \(lon)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


