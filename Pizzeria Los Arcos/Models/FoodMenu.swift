//
//  FoodMenu.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 21/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import Foundation

struct FoodMenu {
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
    
    //MARK: - Hamburguesas
    
    let hamburguesas = [Hamburguesa(name: K.Hamburguesas.Especial.name, description: K.Hamburguesas.Especial.description, price: 39),
                        Hamburguesa(name: K.Hamburguesas.Combinada.name, description: K.Hamburguesas.Combinada.description, price: 54),
                        Hamburguesa(name: K.Hamburguesas.Sencilla.name, description: K.Hamburguesas.Sencilla.description, price: 34),
                        Hamburguesa(name: K.Hamburguesas.Doble.name, description: K.Hamburguesas.Doble.description, price: 44),
                        Hamburguesa(name: K.Hamburguesas.Pollo.name, description: K.Hamburguesas.Pollo.description, price: 34),
                        Hamburguesa(name: K.Hamburguesas.PolloDoble.name, description: K.Hamburguesas.PolloDoble.description, price: 44),
                        Hamburguesa(name: K.Hamburguesas.Filete.name, description: K.Hamburguesas.Filete.description, price: 35),
                        Hamburguesa(name: K.Hamburguesas.Hotdog.name, description: K.Hamburguesas.Hotdog.description, price: 22),
                        Hamburguesa(name: K.Hamburguesas.PapasFrancesa.name, description: K.Hamburguesas.PapasFrancesa.description, price: 21)]
    
    
    //MARK: - Ensaladas
    
    let ensaladas = [Ensaldas(name: K.Ensaladas.LosArcos.name, description: K.Ensaladas.LosArcos.description, price: 45),
                     Ensaldas(name: K.Ensaladas.DeVerduras.name, description: K.Ensaladas.DeVerduras.description, price: 35)]
    
    
    //MARK: - Platillos
    
    let platillos = [Platillos(name: K.Platillos.FajitasArrachera.name, description: K.Platillos.FajitasArrachera.description, price: 98),
                     Platillos(name: K.Platillos.FajitasPollo.name, description: K.Platillos.FajitasPollo.description, price: 72),
                     Platillos(name: K.Platillos.PechugaEmpanizada.name, description: K.Platillos.PechugaEmpanizada.description, price: 69),
                     Platillos.init(name: K.Platillos.PechugaChipotle.name, description: K.Platillos.PechugaChipotle.description, price: 75),
                     Platillos(name: K.Platillos.Espagueti.name
                        , description: K.Platillos.Espagueti.description, price: 42),
                     Platillos(name: K.Platillos.SopaTortilla.name, description: K.Platillos.SopaTortilla.description, price: 38),
                     Platillos(name: K.Platillos.EnchiladasLosArcos.name, description: K.Platillos.EnchiladasLosArcos.description, price: 68),
                     Platillos(name: K.Platillos.EnchiladasColorado.name, description: K.Platillos.EnchiladasColorado.description, price: 64),
                     Platillos(name: K.Platillos.EnchiladasVerde.name, description: K.Platillos.EnchiladasVerde.description, price: 64),
                     Platillos(name: K.Platillos.TacosPicadillo.name, description: K.Platillos.TacosPicadillo.description, price: 50),
                     Platillos(name: K.Platillos.Flautas.name, description: K.Platillos.Flautas.description, price: 50)]
    
    
    //MARK: - Mariscos
    
    let mariscos = [MariscosS(name: "\(K.Mariscos.CoctelCamarones.name), Grande", description: K.Mariscos.CoctelCamarones.description, size: K.SizeM.Grande.size, price: 70),
                    MariscosS(name: "\(K.Mariscos.CoctelCamarones.name), Chico", description: K.Mariscos.CoctelCamarones.description, size: K.SizeM.Chica.size, price: 52),
                    MariscosS(name: "\(K.Mariscos.FileteEmpanizado.name), Grande", description: K.Mariscos.FileteEmpanizado.description, size: K.SizeM.Grande.size, price: 72),
                    MariscosS(name: "\(K.Mariscos.FileteEmpanizado.name), Chico", description: K.Mariscos.FileteEmpanizado.description, size: K.SizeM.Chica.size, price: 48),
                    Mariscos(name: K.Mariscos.CamaronesRancheros.name, description: K.Mariscos.CamaronesRancheros.description, price: 70),
                    Mariscos(name: K.Mariscos.FileteVeracruzana.name, description: K.Mariscos.FileteVeracruzana.description, price: 68),
                    Mariscos(name: K.Mariscos.FileteChipotle.name, description: K.Mariscos.FileteChipotle.description, price: 75)]
    
    
    //MARK: - Desayunos
    
    let desayunos = [Desayunos(name: K.Desayunos.Americano.name, description: K.Desayunos.Americano.description, price: 65),
                     Desayunos(name: K.Desayunos.LosArcos.name, description: K.Desayunos.LosArcos.description, price: 70),
                     Desayunos(name: K.Desayunos.Especial.name, description: K.Desayunos.Especial.description, price: 70),
                     Desayunos(name: K.Desayunos.HuevosDivorciados.name, description: K.Desayunos.HuevosDivorciados.description, price: 63),
                     Desayunos(name: K.Desayunos.HuevosRancheros.name, description: K.Desayunos.HuevosRancheros.description, price: 58),
                     Desayunos(name: K.Desayunos.HuevosMexicana.name, description: K.Desayunos.HuevosMexicana.description, price: 65),
                     Desayunos(name: K.Desayunos.HuevosChilaquiles.name, description: K.Desayunos.HuevosChilaquiles.description, price: 55),
                     Desayunos(name: K.Desayunos.DesayunoNorteño.name, description: K.Desayunos.DesayunoNorteño.description, price: 80),
                     Desayunos(name: K.Desayunos.Montadas.name, description: K.Desayunos.Montadas.description, price: 75),
                     Desayunos(name: K.Desayunos.Huevos.name, description: K.Desayunos.Huevos.description, price: 60),
                     Desayunos(name: K.Desayunos.HuevosMachaca.name, description: K.Desayunos.HuevosMachaca.description, price: 68),
                     Desayunos(name: K.Desayunos.Omelette.name, description: K.Desayunos.Omelette.description, price: 78),
                     Desayunos(name: K.Desayunos.OmeletteJamon.name, description: K.Desayunos.OmeletteJamon.description, price: 68),
                     Desayunos(name: K.Desayunos.OmeletteRajas.name, description: K.Desayunos.OmeletteRajas.description, price: 68),
                     Desayunos(name: K.Desayunos.OmeletteChampiñones.name, description: K.Desayunos.OmeletteChampiñones.description, price: 68),
                     Desayunos(name: K.Desayunos.HotCakesMickeyMouse.name, description: K.Desayunos.HotCakesMickeyMouse.description, price: 55),
                     Desayunos(name: K.Desayunos.HotCakesTriple.name, description: K.Desayunos.HotCakesTriple.description, price: 60),
                     Desayunos(name: K.Desayunos.HotCakesMini.name, description: K.Desayunos.HotCakesMini.description, price: 48),
                     Desayunos(name: K.Desayunos.HotCakes.name, description: K.Desayunos.HotCakes.description, price: 52),
                     Desayunos(name: K.Desayunos.SandwichBLT.name, description: K.Desayunos.SandwichBLT.description, price: 38),
                     Desayunos(name: K.Desayunos.SandwichPollo.name, description: K.Desayunos.SandwichPollo.description, price: 48),
                     Desayunos(name: K.Desayunos.Avena.name, description: K.Desayunos.Avena.description, price: 30)]
    
    
    //MARK: - Bebidas
    
    let bebidas = [Bebidas(name: K.Bebidas.Refrescos.name, description: K.Bebidas.Refrescos.description, price: 17),
                   Bebidas(name: K.Bebidas.FuzeTea.name, description: K.Bebidas.FuzeTea.description, price: 20),
                   Bebidas(name: K.Bebidas.JugoNaranjaVaso.name, description: K.Bebidas.JugoNaranjaVaso.description, price: 17),
                   Bebidas(name: K.Bebidas.JugoNaranjaJarra.name, description: K.Bebidas.JugoNaranjaJarra.description, price: 75),
                   Bebidas(name: K.Bebidas.Agua.name, description: K.Bebidas.Agua.description, price: 10),
                   Bebidas(name: K.Bebidas.LimonadaNaturalVaso.name, description: K.Bebidas.LimonadaNaturalVaso.description, price: 10),
                   Bebidas(name: K.Bebidas.LimonadaNaturalJarra.name, description: K.Bebidas.LimonadaNaturalJarra.description, price: 45),
                   Bebidas(name: K.Bebidas.LimonadaMineralVaso.name, description: K.Bebidas.LimonadaMineralVaso.description, price: 13),
                   Bebidas(name: K.Bebidas.LimonadaMineralJarra.name, description: K.Bebidas.LimonadaMineralJarra.description, price: 55),
                   Bebidas(name: K.Bebidas.Cafe.name, description: K.Bebidas.Cafe.description, price: 18),
                   Bebidas(name: K.Bebidas.Cappuccino.name, description: K.Bebidas.Cappuccino.description, price: 20),
                   Bebidas(name: K.Bebidas.Chocolate.name, description: K.Bebidas.Chocolate.description, price: 18),
                   Bebidas(name: K.Bebidas.Licuado.name, description: K.Bebidas.Licuado.description, price: 23),
                   Bebidas(name: K.Bebidas.Leche.name, description: K.Bebidas.Leche.description, price: 12)]
    
    
    //MARK: - Postres
    
    let postres = [Postres(name: K.Postres.PastelChocolate.name, description: K.Postres.PastelChocolate.description, price: 25),
                   Postres(name: K.Postres.PastelChocolateNieve.name, description: K.Postres.PastelChocolateNieve.description, price: 35),
                   Postres(name: K.Postres.PayQueso.name, description: K.Postres.PayQueso.description, price: 22),
                   Postres(name: K.Postres.PayQuesoNieve.name, description: K.Postres.PayQuesoNieve.description, price: 32),
                   Postres(name: K.Postres.PayNuez.name, description: K.Postres.PayNuez.description, price: 20),
                   Postres(name: K.Postres.PayNuezNieve.name, description: K.Postres.PayNuezNieve.description, price: 30)]
    
    
    
    //MARK: - Malteadas y nieves
    
    let nieves = [Nieves(name: K.NievesMalteadas.Malteada.name, description: K.NievesMalteadas.Malteada.description, price: 18),
                  Nieves(name: K.NievesMalteadas.NieveChica.name, description: K.NievesMalteadas.NieveChica.description, price: 10),
                  Nieves(name: K.NievesMalteadas.NieveMediana.name, description: K.NievesMalteadas.NieveMediana.description, price: 12),
                  Nieves(name: K.NievesMalteadas.NieveGrande.name, description: K.NievesMalteadas.NieveGrande.description, price: 14)]
    
    
    //MARK: - Kids
    
    let kids = [Kids(name: K.Kids.Nuggets.name, description: K.Kids.Nuggets.description, price: 34),
                Kids(name: K.Kids.HotDog.name, description: K.Kids.HotDog.description, price: 32),
                Kids(name: K.Kids.Sandwich.name, description: K.Kids.Sandwich.description, price: 32),
                Kids(name: K.Kids.HamburguesaSteak.name, description: K.Kids.HamburguesaSteak.description, price: 32)]
}
