//
//  Constants.swift
//  StockApp
//
//  Created by Robert Wais on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct Segue {
        //FILL IN
    }
    
    struct UserDefaults {
        //FILL IN
    }
    
    struct CellIdentifiers {
        static let companyCollectionView = "CompanyCollectionViewCell"
        static let chooseStackTableViewCell = "ChooseStockTableViewCell"
    }
    
    struct APICall {

        static let APIKey = "NXO7H3J2KOGFSKOI"

        static let stockTimeLine = "here"
        static let dailySlot = "TIME_SERIES_DAILY"
        static let weeklySlot = "TIME_SERIES_WEEKLY"
        static let monthlySlot = "TIME_SERIES_MONTHLY"
        static let converter =  "https://api.rss2json.com/v1/api.json?rss_url="
        static let newsFinance = "https://feeds.finance.yahoo.com/rss/2.0/headline?s="
        static let region = "&region=US&lang=en-US"
        
        
        //Daily
        //https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=15min&outputsize=compact&apikey=Y0FL3ZP4752EYZ9O
        //converter newsFinance \(ticker) region
//        https://feeds.finance.yahoo.com/rss/2.0/headline?s=ticker(s)&region=US&lang=en-US
        //Function is called to get the correct URL for Alamofire
        
    }
    
    struct testData {
        static let testData = [Company(image: UIImage(named:"appleIcon")!, title: "APPLE", ticker: "AAPL"),
                               Company(image: UIImage(named:"microsoftIcon")!, title: "Microsoft", ticker: "MSFT"),
                            Company(image: UIImage(named:"googleIcon")!, title: "Google", ticker: "GOOG"),
                            Company(image: UIImage(named:"amazonIcon")!, title: "Amazon", ticker: "AMZN"),
                            Company(image: UIImage(named:"netflixIcon")!, title: "Netflix", ticker: "NFLX"),
                            Company(image: UIImage(named:"disneyIcon")!, title: "Walt Disney", ticker: "DIS"),
                            Company(image: UIImage(named:"teslaIcon")!, title: "Tesla", ticker: "TSLA"),
                            Company(image: UIImage(named:"facebookIcon")!, title: "Facebook", ticker: "FB"),
                            Company(image: UIImage(named:"verizonIcon")!, title: "Verizon", ticker: "VZ"),
                            Company(image: UIImage(named:"snapchatIcon")!, title: "Snapchat", ticker: "SNAP"),
                            Company(image: UIImage(named:"twitterIcon")!, title: "Twitter", ticker: "TWTR"),
                            Company(image: UIImage(named:"goproIcon")!, title: "GoPro", ticker: "GPRO"),
                            Company(image: UIImage(named:"bankofamericaIcon")!, title: "Bank of America", ticker: "BAC"),
                            Company(image: UIImage(named:"spotifyIcon")!, title: "Spotify", ticker: "SPOT"),
                            Company(image: UIImage(named:"walmartIcon")!, title: "Walmart", ticker: "WMT")]
        
    }
    static func getData(timeSlot: String,symbol: String)->(String){
        let returnString = "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=\(symbol)&outputsize=compact&apikey=\(APICall.APIKey)"
        return returnString
    }
    
    static func getDaily(symbol: String)->(String){
        
    let returnString = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=15min&outputsize=compact&apikey=\(APICall.APIKey)"
        return returnString
    }
    
    static func getNewsString(symbol: String)->(String){
        let returnString = "\(APICall.converter)\(APICall.newsFinance)\(symbol)\(APICall.region)&api_key=kmyjwu5n3fnwwkvzwgbpk3asu7hubuyv0hjavx2n"
        print("Return string \(returnString)")
        return returnString
    }
    

}


