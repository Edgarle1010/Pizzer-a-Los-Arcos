//
//  OrderCell.swift
//  Pizzeria Los Arcos GM Admin
//
//  Created by Edgar López Enríquez on 07/03/20.
//  Copyright © 2020 Edgar López Enríquez. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    @IBOutlet weak var clientIDLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
