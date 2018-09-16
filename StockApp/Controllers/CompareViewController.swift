//
//  CompareViewController.swift
//  StockApp
//
//  Created by Kevin Singh on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import UIKit
import Charts

class CompareViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var tapToRetry: UIButton!
    
    @IBOutlet weak var loadWheel: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var selectedIndexPath = -1
    var news = [News]()
    var company: Company?
    var entry: Entry?
    var highHigh = 0.0
    var lowLow = 0.0
    var limitLimit1: ChartLimitLine?
    var limitLimit2: ChartLimitLine?
    var testLimit: ChartLimitLine?
    var ll1: ChartLimitLine?
    var ll2: ChartLimitLine?
    @IBOutlet var chartView: LineChartView!
    @IBOutlet  var tableViewDetails: UITableView!

    var chartDataEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
            navigationController?.navigationBar.barStyle = .black
        }
        navigationController?.navigationBar.tintColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.loadWheel.hidesWhenStopped = true
        
        self.title = company?.title

        loadNews()
    
        getData()
        ll1?.lineColor = UIColor.green
        
        // IMPLEMENT STOCK NAME & TICKER
//        self.title = "\(indyCompany.title)"
        self.chartView.data = LineChartData()
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.chartDescription?.text = "Last 30 days"
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
       
        // x-axis limit line
        //ACHTUNG
        //let llXAxis = ChartLimitLine(limit: highestValueInSet, label: "Index 10")
        //llXAxis.lineWidth = 4
        //llXAxis.lineDashLengths = [10, 10, 0]
        //llXAxis.labelPosition = .rightBottom
        //llXAxis.valueFont = .systemFont(ofSize: 10)
        
        //DESTROY GRID
        chartView.xAxis.drawGridLinesEnabled = false
        
        //GRID LINES
        
        //chartView.xAxis.gridLineDashLengths = [10, 10]
        //chartView.xAxis.gridLineDashPhase = 0
        chartView.xAxis.drawLabelsEnabled = false
        
        
        //leftAxis.gridLineDashLengths = [5, 5]
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        
        //chartView.animate(xAxisDuration: 3)

    }
    
    @IBAction func retryPressed(_ sender: Any) {
        getData()
        tapToRetry.isHidden = true
    }
    
    func loadNews() {
        if let ticker = company?.ticker {
            StockData.stockNews(symbol: ticker) { (newsData) in
                self.news = newsData
                self.tableView.reloadData()
            }
        }
    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
    
    //UPPER AND LOWER BOUND LINES
    
    //DEFINING HIGHEST AND LOWEST VALUES IN DATA SET
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension CompareViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell") as! GraphTableViewCell
        cell.titleLabel.text = news[indexPath.row].title
        cell.descriptionLabel.text = news[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "News"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndexPath == indexPath.row {
            selectedIndexPath = -1
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }else{
            selectedIndexPath = indexPath.row
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
        
//        var otherCells = tableView
//        for index in 0..<otherCells!.count {
//            var tempCell = otherCells![index]
//            if indexPath == tempCell {
//                otherCells?.remove(at: index)
//            }
//        }
//        tableView.reloadRows(at: otherCells!, with: UITableViewRowAnimation.none)
    }
    
}

extension CompareViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndexPath {
            return 350
        } else {
            return 100
        }
    }
}

extension CompareViewController {
    //Get (high, low)
    func getHighLow(entries: [Entry])->(Int,Int){
        var high:Double = 0
        var low:Double = 0
        for index in (entries.count - 30) ..< entries.count {
            if let number = Double(entries[index].high){
                if  number > high {
                    high = number
                }
                if low == 0 {
                    low = number
                }else if number < low {
                    low = number
                }
            }
        }
        
        return (Int(high),Int(low))
    }
    
    func presentAlert(){
        let alert = UIAlertController(title: "Error",
                                      message: "To Many API Calls in the last minute",
                                      preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
            self.getData()
        })
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in
            
            self.tapToRetry.isHidden = false
            
            
        })
        alert.addAction(cancel)
        alert.addAction(submitAction)
        present(alert, animated: true, completion: nil)
    }
    
    func getData(){
        loadWheel.startAnimating()
        guard let indyCompany = company else {
            return
        }
        StockData.getStockTime(timeSlot: Constants.APICall.monthlySlot, symbol: (indyCompany.ticker)) { (data) in
            self.loadWheel.stopAnimating()
            
            if data.count<1{
                self.presentAlert()
                return
            }
            print("\(data.count)")
            
            
            var count = data.count
            for index in (data.count - 30) ..< data.count {
                self.chartDataEntry.append(ChartDataEntry(x: Double(index), y: Double(data[index].high)!))
            }
                                                                                                       
            let set1 = LineChartDataSet(values: self.chartDataEntry, label: "\(indyCompany.title) USD Stock Price")
            self.chartView.data = LineChartData(dataSet: set1)
            var highAndLow = self.getHighLow(entries: data)
            self.chartView.leftAxis.axisMaximum = Double(highAndLow.0 + 5)
            self.chartView.leftAxis.axisMinimum = Double(highAndLow.1 - 5)
            set1.circleRadius = 1
            set1.valueFont = .systemFont(ofSize: 0)
            set1.lineWidth = 2.5
            self.chartView.xAxis.axisLineWidth = 0
            self.chartView.animate(xAxisDuration: 0.5)
            self.highHigh = Double(highAndLow.0)
            self.lowLow = Double(highAndLow.1)
            
            let ll1 = ChartLimitLine(limit: self.highHigh, label: "Monthly High $\(self.highHigh)")
            let ll2 = ChartLimitLine(limit: self.lowLow, label: "Monthly Low $\(self.lowLow)")
            
            let leftAxis = self.chartView.leftAxis
            leftAxis.drawLimitLinesBehindDataEnabled = false
            leftAxis.drawGridLinesEnabled = false
            self.ll1?.lineWidth = 4
            self.ll1?.lineDashLengths = [5,5]
            self.ll1?.labelPosition = .rightTop
            self.ll1?.valueFont = .systemFont(ofSize: 15)
            self.ll1?.lineColor = UIColor.green
            self.ll1?.valueTextColor = UIColor.white
            
            
            self.limitLimit2?.lineWidth = 4
            self.limitLimit2?.lineDashLengths = [5,5]
            self.limitLimit2?.labelPosition = .rightBottom
            self.limitLimit2?.valueFont = .systemFont(ofSize: 10)
            self.limitLimit2?.lineColor = UIColor.green
            self.ll2?.valueTextColor = UIColor.white
            
            leftAxis.addLimitLine(ll1)
            leftAxis.addLimitLine(ll2)
        }
    }
}

