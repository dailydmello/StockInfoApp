//
//  PortfolioDetailViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/18/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit

class PortfolioDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var name = ""
    
    @IBOutlet var numberButton: [UIButton]!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cbutton: UIButton!
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        addValueTextField.text = nil
    }
    

    @IBAction func deleteLastNumberTapped(_ sender: UIButton) {
        if (addValueTextField.text?.count)! > 0 {
        addValueTextField.text?.removeLast()
        }
    }
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        
        
        updateTextField(number: "\(sender.tag)")
    }
    @IBOutlet weak var addValueTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var actualPriceValue: UILabel!
    @IBAction func addToPortfolioButtonTapped(_ sender: UIButton) {
        guard let amountText = addValueTextField.text else {
            print("no text")
            return
        }
        guard let textPrice = actualPriceValue.text else {
            print("no price text")
            return
        }
        guard let price = Double(textPrice) else {
            print("No price")
            return
        }
        guard let amount = Int32(amountText) else {
            print("No amount")
            return
        }
        let newPort = CoreDataHelper.newPortfolio()
        newPort.amount = amount
        newPort.ticker = name
        newPort.value = price
        newPort.name = name
        CoreDataHelper.savePortfolio()
        self.performSegue(withIdentifier: "unwindToDetails", sender: self)
        print("Button pressed")
        self.view.endEditing(true)
        //
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("YASSSS")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
        }
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.title = "Add New Portfolio"
        tableView.dataSource = self
        tableView.delegate = self
        addValueTextField.isUserInteractionEnabled = false
        setButtons()
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PortfolioDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.testData.testData.count
    }
    
    func updateTextField(number: String) {
        if (addValueTextField.text?.count)! <= 4 {
        if addValueTextField.text == "0" {
            addValueTextField.text = nil
            addValueTextField.text = (addValueTextField.text ?? "") + number
        } else {
            addValueTextField.text = (addValueTextField.text ?? "") + number
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.chooseStackTableViewCell) as! ChooseStockTableViewCell
        var tempCompany = Constants.testData.testData[indexPath.row]
        cell.cellNameLbl.text = (tempCompany.ticker)
        cell.accessoryType = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose Stock"
    }
}


extension PortfolioDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Lets the user know a cell is being loaded"
        let cell = tableView.cellForRow(at: indexPath) as! ChooseStockTableViewCell
        var tempCompany = Constants.testData.testData[indexPath.row]
        cell.cellNameLbl.text = "\(tempCompany.ticker) (Loading..)"
        
        //disable cell touching
        tableView.allowsSelection=false
        StockData.getDailyStocks(symbol: Constants.testData.testData[indexPath.row].ticker) { (data) in
            if data.count > 1{
                self.name = Constants.testData.testData[indexPath.row].ticker
                tableView.allowsSelection = true
                self.actualPriceValue.text = "\(data[data.count-1].high)"
                tableView.reloadData()
            }else {
                //renable cell touchiing
                tableView.allowsSelection=true
                let cell = tableView.cellForRow(at: indexPath) as! ChooseStockTableViewCell
                cell.accessoryType = .checkmark
                var tempCompany = Constants.testData.testData[indexPath.row]
                cell.cellNameLbl.text = "\(tempCompany.ticker) (Tap to Retry -- API Call Limit Reached)"
            }
            
        }
    }
}

extension PortfolioDetailViewController {
    func setButtons() {
        let borderColor = UIColor.lightGray.cgColor
        let borderWidth = 0.5
        for button in numberButton {
            button.layer.borderColor = borderColor
            button.layer.borderWidth = CGFloat(borderWidth)
        }
    }
}
