//
//  Orders.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

struct Orders {
    let foodName: String
    let quantity: Int
    let extraIngredient: [String:Int]
    let price: Double
    let comments: String
    
    init(foodName: String, quantity: Int, extraIngredient: [String:Int], price: Double, comments: String) {
        self.foodName = foodName
        self.quantity = quantity
        self.extraIngredient = extraIngredient
        self.price = price
        self.comments = comments
    }
}

struct OrdersList {
    static var ordersList: [Orders] = []
}
