//
//  Pizzas.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 10/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

struct Pizzas {
    let name: String
    let description: String
    let size: String
    let price: Int
    
    init(name: String, description: String, size: String, price: Int) {
        self.name = name
        self.description = description
        self.size = size
        self.price = price
    }
    
    
}

struct PizzasList {
    let pizzas = [Pizzas(name: K.PizzasM.LosArcos.name, description: K.PizzasM.LosArcos.description, size: K.SizeM.Chica.size, price: 73),
                  Pizzas(name: K.PizzasM.LosArcos.name, description: K.PizzasM.LosArcos.description, size: K.SizeM.Medina.size, price: 106),
                  Pizzas(name: K.PizzasM.LosArcos.name, description: K.PizzasM.LosArcos.description, size: K.SizeM.Grande.size, price: 134),
                  Pizzas(name: K.PizzasM.Especial.name, description: K.PizzasM.Especial.description, size: K.SizeM.Chica.size, price: 73),
                  Pizzas(name: K.PizzasM.Especial.name, description: K.PizzasM.Especial.description, size: K.SizeM.Medina.size, price: 106),
                  Pizzas(name: K.PizzasM.Especial.name, description: K.PizzasM.Especial.description, size: K.SizeM.Grande.size, price: 134),
                  Pizzas(name: K.PizzasM.Vegetariana.name, description: K.PizzasM.Vegetariana.description, size: K.SizeM.Chica.size, price: 73),
                  Pizzas(name: K.PizzasM.Vegetariana.name, description: K.PizzasM.Vegetariana.description, size: K.SizeM.Medina.size, price: 106),
                  Pizzas(name: K.PizzasM.Vegetariana.name, description: K.PizzasM.Vegetariana.description, size: K.SizeM.Grande.size, price: 134),
                  Pizzas(name: K.PizzasM.Mexicana.name, description: K.PizzasM.Mexicana.description, size: K.SizeM.Chica.size, price: 73),
                  Pizzas(name: K.PizzasM.Mexicana.name, description: K.PizzasM.Mexicana.description, size: K.SizeM.Medina.size, price: 106),
                  Pizzas(name: K.PizzasM.Mexicana.name, description: K.PizzasM.Mexicana.description, size: K.SizeM.Grande.size, price: 134),
                  Pizzas(name: K.PizzasM.JamonPiña.name, description: K.PizzasM.JamonPiña.description, size: K.SizeM.Chica.size, price: 73),
                  Pizzas(name: K.PizzasM.JamonPiña.name, description: K.PizzasM.JamonPiña.description, size: K.SizeM.Medina.size, price: 106),
                  Pizzas(name: K.PizzasM.JamonPiña.name, description: K.PizzasM.JamonPiña.description, size: K.SizeM.Grande.size, price: 134),
                  Pizzas(name: K.PizzasM.Pepperoni.name, description: K.PizzasM.Pepperoni.description, size: K.SizeM.Chica.size, price: 73),
                  Pizzas(name: K.PizzasM.Pepperoni.name, description: K.PizzasM.Pepperoni.description, size: K.SizeM.Medina.size, price: 106),
                  Pizzas(name: K.PizzasM.Pepperoni.name, description: K.PizzasM.Pepperoni.description, size: K.SizeM.Grande.size, price: 134),
                  Pizzas(name: K.PizzasM.Camarones.name, description: K.PizzasM.Camarones.description, size: K.SizeM.Chica.size, price: 84),
                  Pizzas(name: K.PizzasM.Camarones.name, description: K.PizzasM.Camarones.description, size: K.SizeM.Medina.size, price: 121),
                  Pizzas(name: K.PizzasM.Camarones.name, description: K.PizzasM.Camarones.description, size: K.SizeM.Grande.size, price: 151),
                  Pizzas(name: K.PizzasM.Salami.name, description: K.PizzasM.Salami.description, size: K.SizeM.Chica.size, price: 62),
                  Pizzas(name: K.PizzasM.Salami.name, description: K.PizzasM.Salami.description, size: K.SizeM.Medina.size, price: 92),
                  Pizzas(name: K.PizzasM.Salami.name, description: K.PizzasM.Salami.description, size: K.SizeM.Grande.size, price: 118),
                  Pizzas(name: K.PizzasM.JamonPavo.name, description: K.PizzasM.JamonPavo.description, size: K.SizeM.Chica.size, price: 62),
                  Pizzas(name: K.PizzasM.JamonPavo.name, description: K.PizzasM.JamonPavo.description, size: K.SizeM.Medina.size, price: 92),
                  Pizzas(name: K.PizzasM.JamonPavo.name, description: K.PizzasM.JamonPavo.description, size: K.SizeM.Grande.size, price: 118),
                  Pizzas(name: K.PizzasM.Picadillo.name, description: K.PizzasM.Picadillo.description, size: K.SizeM.Chica.size, price: 62),
                  Pizzas(name: K.PizzasM.Picadillo.name, description: K.PizzasM.Picadillo.description, size: K.SizeM.Medina.size, price: 92),
                  Pizzas(name: K.PizzasM.Picadillo.name, description: K.PizzasM.Picadillo.description, size: K.SizeM.Grande.size, price: 118),
                  Pizzas(name: K.PizzasM.SalchichaPavoChampiñones.name, description: K.PizzasM.SalchichaPavoChampiñones.description, size: K.SizeM.Chica.size, price: 62),
                  Pizzas(name: K.PizzasM.SalchichaPavoChampiñones.name, description: K.PizzasM.SalchichaPavoChampiñones.description, size: K.SizeM.Medina.size, price: 92),
                  Pizzas(name: K.PizzasM.SalchichaPavoChampiñones.name, description: K.PizzasM.SalchichaPavoChampiñones.description, size: K.SizeM.Grande.size, price: 118),]
    
    func getPizzaPrice(name: String, size: String) -> Int {
        let pizza = pizzas.filter { $0.size == size && $0.name == name }
        return pizza[0].price
    }
    
}

