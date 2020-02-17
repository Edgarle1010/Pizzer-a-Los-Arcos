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
    let quantity: Double
    let price: Float
    let comments: String
    
    init(foodName: String, quantity: Double, price: Float, comments: String) {
        self.foodName = foodName
        self.quantity = quantity
        self.price = price
        self.comments = comments
    }
}
