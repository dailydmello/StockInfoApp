//
//  PortfolioStockTableViewCell.swift
//  StockApp
//
//  Created by Kevin Singh on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit
//TODO: COMPLETE THIS CONTROLLER BY DESIGN (HINT: COMPAREVIEWCONTROLLER), FIX CONSTRAINTS FOR STACKVIEW - CHECK THE VIEW ON iPHONE SE, 8 PLUS,...

class PortfolioStockTableViewCell: UITableViewCell {

    @IBOutlet weak var stockTitle: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var stockAmount: UILabel!
    @IBOutlet weak var stockValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
