//
//  CompanyCollectionViewCell.swift
//  StockApp
//
//  Created by Robert Wais on 7/17/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit

//protocol CompanyCollectionCellDelegate: class {
//    func companySelected(on cell:CompanyCollectionViewCell)
//}

class CompanyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var companyTitle: UILabel!
    
    
    func configureCell(company: Company){
        imageView.image = company.image
        companyTitle.text = company.title
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.5129660964, blue: 0.8761830926, alpha: 1)
        self.layer.borderWidth = 2.0
    }
    
}
