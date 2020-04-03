//
//  Pizzas.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

class Food {
    let name: String
    let description: String
    let price: Int
    
    init(name: String, description: String, price: Int) {
        self.name = name
        self.description = description
        self.price = price
    }
}

class Pizzas: Food {
    let size: String
    
    init(name: String, description: String, size: String, price: Int) {
        self.size = size
        super.init(name: name, description: description, price: price)
    }
}

class Hamburguesa: Food {
    
}

class Ensaldas: Food {
    
}

class Platillos: Food {
    
}

class Mariscos: Food {
    
}

class MariscosS: Mariscos {
    let size: String
    
    init(name: String, description: String, size: String, price: Int) {
        self.size = size
        super.init(name: name, description: description, price: price)
    }
}

class Desayunos: Food {
    
}

class Bebidas: Food {
    
}

class Postres: Food {
    
}

class Nieves: Food {
    
}

class Kids: Food {
    
}

