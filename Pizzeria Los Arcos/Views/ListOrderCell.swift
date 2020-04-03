//
//  ListOrderCell.swift
//  Pizzeria Los Arcos
//
//  Created by Edgar López Enríquez on 18/02/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class ListOrderCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var extraIngredientLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
