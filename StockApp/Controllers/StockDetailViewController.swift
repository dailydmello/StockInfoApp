//
//  StockDetailViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/17/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
        }
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
