//
//  ExtraIngreditMenu.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 23/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

struct ExtraIngredientMenu {
    let pizza = [ExtraPizza(name: K.ExtraM.Pepperoni.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Pepperoni.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Pepperoni.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Jamon.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Jamon.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Jamon.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.JamonPavo.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.JamonPavo.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.JamonPavo.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Salami.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Salami.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Salami.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Queso.name, size: K.SizeM.Chica.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Queso.name, size: K.SizeM.Medina.size, price: 15),
                 ExtraPizza(name: K.ExtraM.Queso.name, size: K.SizeM.Grande.size, price: 20),
                 ExtraPizza(name: K.ExtraM.Tocino.name, size: K.SizeM.Chica.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Tocino.name, size: K.SizeM.Medina.size, price: 15),
                 ExtraPizza(name: K.ExtraM.Tocino.name, size: K.SizeM.Grande.size, price: 20),
                 ExtraPizza(name: K.ExtraM.Camarones.name, size: K.SizeM.Chica.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Camarones.name, size: K.SizeM.Medina.size, price: 15),
                 ExtraPizza(name: K.ExtraM.Camarones.name, size: K.SizeM.Grande.size, price: 20),
                 ExtraPizza(name: K.ExtraM.PimientoMorron.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.PimientoMorron.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.PimientoMorron.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Champinones.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Champinones.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Champinones.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Cebolla.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Cebolla.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Cebolla.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Tomate.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Tomate.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Tomate.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Pina.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Pina.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Pina.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Topping.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Topping.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Topping.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Frijoles.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Frijoles.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Frijoles.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Jalapenos.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Jalapenos.name, size: K.SizeM.Medina.size, price: 8),
                 ExtraPizza(name: K.ExtraM.Jalapenos.name, size: K.SizeM.Grande.size, price: 10),]
    
    let others = [ExtraOthers(name: K.ExtraM.CopaPina.name, price: 20),
                  ExtraOthers(name: K.ExtraM.Pan.name, price: 6),
                  ExtraOthers(name: K.ExtraM.Arroz.name, price: 5),
                  ExtraOthers(name: K.ExtraM.Frijolitos.name, price: 5),
                  ExtraOthers(name: K.ExtraM.TocinoOthers.name, price: 15)]
    
}
