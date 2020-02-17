//
//  ExtraIngredient.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 12/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

struct Extra {
    let name: String
    let size: String
    let price: Int
    
    init(name: String, size: String, price: Int) {
        self.name = name
        self.size = size
        self.price = price
    }
}

struct ExtraList {
    let extra = [Extra(name: K.ExtraM.Pepperoni.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Pepperoni.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Pepperoni.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Jamon.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Jamon.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Jamon.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.JamonPavo.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.JamonPavo.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.JamonPavo.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Salami.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Salami.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Salami.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Queso.name, size: K.SizeM.Chica.size, price: 10),
                 Extra(name: K.ExtraM.Queso.name, size: K.SizeM.Medina.size, price: 15),
                 Extra(name: K.ExtraM.Queso.name, size: K.SizeM.Grande.size, price: 20),
                 Extra(name: K.ExtraM.Tocino.name, size: K.SizeM.Chica.size, price: 10),
                 Extra(name: K.ExtraM.Tocino.name, size: K.SizeM.Medina.size, price: 15),
                 Extra(name: K.ExtraM.Tocino.name, size: K.SizeM.Grande.size, price: 20),
                 Extra(name: K.ExtraM.Camarones.name, size: K.SizeM.Chica.size, price: 10),
                 Extra(name: K.ExtraM.Camarones.name, size: K.SizeM.Medina.size, price: 15),
                 Extra(name: K.ExtraM.Camarones.name, size: K.SizeM.Grande.size, price: 20),
                 Extra(name: K.ExtraM.PimientoMorron.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.PimientoMorron.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.PimientoMorron.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Champinones.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Champinones.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Champinones.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Cebolla.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Cebolla.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Cebolla.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Tomate.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Tomate.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Tomate.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Pina.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Pina.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Pina.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Topping.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Topping.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Topping.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Frijoles.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Frijoles.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Frijoles.name, size: K.SizeM.Grande.size, price: 10),
                 Extra(name: K.ExtraM.Jalapenos.name, size: K.SizeM.Chica.size, price: 5),
                 Extra(name: K.ExtraM.Jalapenos.name, size: K.SizeM.Medina.size, price: 8),
                 Extra(name: K.ExtraM.Jalapenos.name, size: K.SizeM.Grande.size, price: 10),]
    
    var extraOpt = [Extra(name: K.ExtraM.Pepperoni.name, size: K.SizeM.Grande.size, price: 10)]
}
