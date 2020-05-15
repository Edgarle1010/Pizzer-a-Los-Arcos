//
//  AccountViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 09/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logOutButton: UIButton!
    
    let headerTitles = [" "," "," "]
    let cellData = [["Historial de pedidos"], ["Como llegar", "Llamar"], ["Comentarios"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.layer.cornerRadius = 20

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "Cuenta"
    }
    
//    func openMaps() {
//
//        let latitude: CLLocationDegrees = 28.4482254
//        let longitude: CLLocationDegrees = -106.8229544
//
//        let regionDistance: CLLocationDistance = 1000
//        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//
//        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinate: regionSpan.center)]
//
//        let placeMark = MKPlacemark(coordinate: coordinates)
//        let mapItem = MKMapItem(placemark: placeMark)
//
//        mapItem.openInMaps(launchOptions: options)
//
//    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
            
            removeImage(itemName: "Items", fileExtension: "plist")
            
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func removeImage(itemName:String, fileExtension: String) {
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
        do {
            try fileManager.removeItem(atPath: filePath)
            OrdersList.ordersList.removeAll()
            print("Here")
        } catch let error as NSError {
            print(error.debugDescription)
        }}
    
    //MARK: - TableView Datasource & Delegated Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        cell.textLabel?.text = cellData[indexPath.section][indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        if cell.textLabel?.text == "Historial de pedidos" {
            cell.imageView?.image = UIImage(systemName: "doc.text.magnifyingglass")
        } else if cell.textLabel?.text == "Llamar" {
            cell.imageView?.image = UIImage(systemName: "phone")
        } else if cell.textLabel?.text == "Comentarios" {
            cell.imageView?.image = UIImage(systemName: "envelope")
        } else {
            cell.imageView?.image = UIImage(systemName: "map")
        }
        
        cell.imageView?.tintColor = UIColor(named: "BrandBrow")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        if cell == "Historial de pedidos" {
            performSegue(withIdentifier: "MoreToHistory", sender: self)
        } else if cell == "Como llegar" {
            UIApplication.shared.open(NSURL(string: "http://maps.apple.com/?daddr=Los+Arcos+Gomez+Morin+Cuauhtemoc,14&dirflg=d&t=h")! as URL)
        } else if cell == "Llamar" {
            if let url = URL(string: "tel://6255834400") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        } else if cell == "Comentarios" {
            if let url = URL(string: "mailto:pizzeriagmapp@gmail.com") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }

        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor(named: "BrandLightBrow")
        
        return vw
    }
    
}
