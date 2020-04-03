//
//  ExtraIngredient.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 12/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

class Extra {
    let name: String
    let price: Int
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

class ExtraPizza: Extra {
    let size: String
    
    init(name: String, size: String, price: Int)
    {
        self.size = size
        super.init(name: name, price: price)
    }
    
}

class ExtraOthers: Extra {
    
}
