//
//  Company.swift
//  StockApp
//
//  Created by Robert Wais on 7/17/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation
import UIKit

struct Company {
    var image: UIImage
    var title: String
    var ticker: String
    
    init(image: UIImage, title: String, ticker: String) {
        self.image = image
        self.title = title
        self.ticker = ticker
    }
}
