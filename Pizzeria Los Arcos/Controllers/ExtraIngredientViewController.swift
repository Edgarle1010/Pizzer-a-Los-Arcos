//
//  ExtraIngredientViewController.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 12/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class ExtraIngredientViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var foodType: String?
    var foodName: String?
    var extraOpt: [Extra] = []
    var back: UIViewController?
    
    var extraList = ExtraIngredientMenu()
    var sizeCurrent: String?
    var nameExtra = ""
    var priceExtra = 0
    var quantity: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch foodType {
        case "Pizzas":
            extraOpt = extraList.pizza.filter { $0.size == sizeCurrent }
        case "Desayunos":
             extraOpt = extraList.desayunos
        case "Hamburguesas":
            if foodName == K.Hamburguesas.Hotdog.name {
                extraOpt = extraList.hotdog
            } else {
                extraOpt = extraList.hamburguesas
            }
        case "Platillos":
            if foodName == K.Platillos.Espagueti.name {
                extraOpt = extraList.espagueti
            } else if foodName == K.Platillos.SopaTortilla.name {
                extraOpt = extraList.sopaTortilla
            } else if foodName == K.Platillos.EnchiladasLosArcos.name || foodName == K.Platillos.EnchiladasVerde.name || foodName == K.Platillos.EnchiladasColorado.name || foodName == K.Platillos.Flautas.name || foodName == K.Platillos.TacosPicadillo.name {
                extraOpt = extraList.enchiladas
            } else {
                extraOpt = extraList.platillos
            }
        case "Mariscos":
            if let name = foodName {
                if name.contains("Filete") {
                    extraOpt = extraList.filetes
                } else if foodName == K.Mariscos.CamaronesRancheros.name {
                    extraOpt = extraList.camaronRanchero
                } else {
                    extraOpt = extraList.mariscos
                }
            }
        case "Ensaladas":
            extraOpt = extraList.ensaladas
        default:
            extraOpt = extraList.others
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.nameExtra = self.extraOpt[0].name
        self.priceExtra = self.extraOpt[0].price
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        switch foodType {
        case "Pizzas":
            if let backVC = presentingViewController as? PizzasViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
        case "Hamburguesas":
            if let backVC = presentingViewController as? BurgerViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
        case "Platillos":
            if let backVC = presentingViewController as? BurgerViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
            if let backVC = presentingViewController as? SaucersViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
        case "Mariscos":
            if let backVC = presentingViewController as? BurgerViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
        case "Desayunos":
            if let backVC = presentingViewController as? BreakfastsViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
            if let backVC = presentingViewController as? BreakfastsEggsViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
            if let backVC = presentingViewController as? BreakfastsEggs2ViewController {
                let value = backVC.extraIngredientStepper.value - 1
                backVC.extraIngredientStepper.value = value
                backVC.oldValue = value
                backVC.extraIngredientStepper.sendActions(for: .valueChanged)
                dismiss(animated: true, completion: nil)
            }
        case "Ensaladas":
        if let backVC = presentingViewController as? BurgerViewController {
            let value = backVC.extraIngredientStepper.value - 1
            backVC.extraIngredientStepper.value = value
            backVC.oldValue = value
            backVC.extraIngredientStepper.sendActions(for: .valueChanged)
            dismiss(animated: true, completion: nil)
        }
        default: break
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        guard let quantity = quantity else { fatalError() }
        
        switch foodType {
        case "Pizzas":
            if let backVC = presentingViewController as? PizzasViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Double(priceExtra) * Double(quantity)
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        case "Hamburguesas":
            if let backVC = presentingViewController as? BurgerViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Int(Double(priceExtra) * Double(quantity))
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        case "Ensaladas":
            if let backVC = presentingViewController as? BurgerViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Int(Double(priceExtra) * Double(quantity))
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        case "Platillos":
            if let backVC = presentingViewController as? SaucersViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Double(priceExtra) * Double(quantity)
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
            if let backVC = presentingViewController as? BurgerViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Int(Double(priceExtra) * Double(quantity))
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        case "Mariscos":
            if let backVC = presentingViewController as? BurgerViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Int(Double(priceExtra) * Double(quantity))
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        case "Desayunos":
            if let backVC = presentingViewController as? BreakfastsViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Double(priceExtra) * Double(quantity)
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
            if let backVC = presentingViewController as? BreakfastsEggsViewController {
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Double(priceExtra) * Double(quantity)
                    backVC.viewDidLoad()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
            if let backVC = presentingViewController as? BreakfastsEggs2ViewController {
                
                if backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] != nil {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "El ingrediente extra seleccionado ya esta agregado, por favor selecciona otro.", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    backVC.extraIngredients["(Cantidad: \(quantity)) \(nameExtra) ($\(priceExtra))\n"] = priceExtra
                    backVC.extraIngredientLabel.text = ""
                    priceExtra = 0
                    for data in backVC.extraIngredients {
                        backVC.extraIngredientLabel.text?.append("\(data.key)")
                        priceExtra += data.value
                    }
                    backVC.extraPrice = Double(priceExtra) * Double(quantity)
                    backVC.getTotal()
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        default: break
        }
    }
}

extension ExtraIngredientViewController: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return extraOpt.count
    }
    
}

extension ExtraIngredientViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(extraOpt[row].name) ($\(extraOpt[row].price))"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameExtra = extraOpt[row].name
        priceExtra = extraOpt[row].price
    }
    
}

