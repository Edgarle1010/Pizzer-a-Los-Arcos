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
                 ExtraPizza(name: K.ExtraM.Jalapenos.name, size: K.SizeM.Grande.size, price: 10),
                 ExtraPizza(name: K.ExtraM.Ranch.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Ranch.name, size: K.SizeM.Medina.size, price: 5),
                 ExtraPizza(name: K.ExtraM.Ranch.name, size: K.SizeM.Grande.size, price: 5),
                 ExtraPizza(name: K.ExtraM.QuesoParmesano.name, size: K.SizeM.Chica.size, price: 5),
                 ExtraPizza(name: K.ExtraM.QuesoParmesano.name, size: K.SizeM.Medina.size, price: 5),
                 ExtraPizza(name: K.ExtraM.QuesoParmesano.name, size: K.SizeM.Grande.size, price: 5)]
    
    let desayunos = [ExtraDesayunos(name: K.ExtraM.TortaPapa.name, price: 8),
                     ExtraDesayunos(name: K.ExtraM.Frijoles.name, price: 0),
                     ExtraDesayunos(name: K.ExtraM.Rajas.name, price: 8),
                     ExtraDesayunos(name: K.ExtraM.ChuletaAhumada.name, price: 22),
                     ExtraDesayunos(name: K.ExtraM.PapasFrancesa.name, price: 11),
                     ExtraDesayunos(name: K.ExtraM.Huevo.name, price: 5),
                     ExtraDesayunos(name: K.ExtraM.Jamon.name, price: 8),
                     ExtraDesayunos(name: K.ExtraM.Arroz.name, price: 15),
                     ExtraDesayunos(name: K.ExtraM.FajitasRes.name, price: 40),
                     ExtraDesayunos(name: K.ExtraM.HotCake.name, price: 20),
                     ExtraDesayunos(name: K.ExtraM.ChilaquilesRojos.name, price: 10),
                     ExtraDesayunos(name: K.ExtraM.ChilaquilesVerdes.name, price: 10)]
    
    let hamburguesas = [ExtraHamburguesa(name: K.ExtraM.Pina.name, price: 8),
                        ExtraHamburguesa(name: K.ExtraM.Jamon.name, price: 5),
                        ExtraHamburguesa(name: K.ExtraM.TocinoOthers.name, price: 15),
                        ExtraHamburguesa(name: K.ExtraM.CarneRes.name, price: 10),
                        ExtraHamburguesa(name: K.ExtraM.Queso.name, price: 5),
                        ExtraHamburguesa(name: K.ExtraM.CarnePollo.name, price: 10)]
    
    let ensaladas = [ExtraEnsaladas(name: K.ExtraM.Jamon.name, price: 12),
                     ExtraEnsaladas(name: K.ExtraM.Tocino.name, price: 25),
                     ExtraEnsaladas(name: K.ExtraM.Champinones.name, price: 12),
                     ExtraEnsaladas(name: K.ExtraM.Queso.name, price: 12),
                     ExtraEnsaladas(name: K.ExtraM.PechugaPollo.name, price: 15)]
    
    let platillos = [ExtraPlatillos(name: K.ExtraM.Frijoles.name, price: 0),
                     ExtraPlatillos(name: K.ExtraM.Arroz.name, price: 15),
                     ExtraPlatillos(name: K.ExtraM.Verdura.name, price: 0),
                     ExtraPlatillos(name: K.ExtraM.Rajas.name, price: 8),
                     ExtraPlatillos(name: K.ExtraM.PapasFrancesa.name, price: 11),
                     ExtraPlatillos(name: K.ExtraM.PechugaPollo.name, price: 15),
                     ExtraPlatillos(name: K.ExtraM.Tocino.name, price: 25)]
    
    let mariscos = [ExtraMariscos(name: K.ExtraM.Camarones.name, price: 25),
                    ExtraMariscos(name: K.ExtraM.Pan.name, price: 5)]
    
    let others = [ExtraOthers(name: K.ExtraM.CarneRes.name, price: 10),
                  ExtraOthers(name: K.ExtraM.CarnePollo.name, price: 10),
                  ExtraOthers(name: K.ExtraM.TocinoOthers.name, price: 15),
                  ExtraOthers(name: K.ExtraM.Pina.name, price: 8),
                  ExtraOthers(name: K.ExtraM.CopaPina.name, price: 20),
                  ExtraOthers(name: K.ExtraM.Pan.name, price: 6),
                  ExtraOthers(name: K.ExtraM.Arroz.name, price: 5),
                  ExtraOthers(name: K.ExtraM.Frijolitos.name, price: 5)]
    
}
