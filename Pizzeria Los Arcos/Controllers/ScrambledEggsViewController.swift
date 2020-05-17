//
//  ScrambledEggsViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 16/05/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class ScrambledEggsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let scrambledIngredientList = ["Jamón", "Tocino", "Con queso", "Chorizo", "Mexicana", "Machaca (+$20)", "Ninguno"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FoodCell", bundle: nil), forCellReuseIdentifier: "listCell")

    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        if let backVC = presentingViewController as? BreakfastsEggsViewController {
            backVC.starryStyleButton.sendActions(for: .touchUpInside)
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    //MARK: - tableView Delegate & Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrambledIngredientList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! FoodCell
        cell.title.text = scrambledIngredientList[indexPath.row]
        cell.descriptionLabel.text = ""
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let backVC = presentingViewController as? BreakfastsEggsViewController {
            
            backVC.scrambledIngredientLabel.text = "Ingrediente: \(scrambledIngredientList[indexPath.row])"
            backVC.scrambledIngredient = scrambledIngredientList[indexPath.row]
            if scrambledIngredientList[indexPath.row] == "Machaca (+$20)" {
                backVC.scrambledIngredientPrice = 20
            }
            
            backVC.viewDidLoad()
            dismiss(animated: true, completion: nil)
            
        }
    }

}
