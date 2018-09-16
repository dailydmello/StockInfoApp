//
//  Entry.swift
//  StockApp
//
//  Created by Robert Wais on 7/16/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation


//The way the JSON will be returned as follows
//"2018-07-16": {
//    "1. open": "105.4000",
//    "2. high": "105.8200",
//    "3. low": "104.5150",
//    "4. close": "104.8800",
//    "5. volume": "21779634"
//},

struct Entry {
    var _open: String?
    var _high: String?
    var _low: String?
    var _close: String?
    var _volume: String?
    var _timeFrame: Date
    
    var open: String {
        guard let openCost = _open else {
            print("ERROR")
            return ""
        }
        return openCost
    }
    
    var high: String {
        guard let highCost = _high else {
            print("ERROR")
            return ""
        }
        return highCost
    }
    
    var low: String {
        guard let lowCost = _low else {
            print("ERROR")
            return ""
        }
        return lowCost
    }
    
    var close: String {
        guard let closeCost = _close else {
            print("ERROR")
            return ""
        }
        return closeCost
    }
    
    var volume: String {
        guard let volume = _volume else {
            print("ERROR")
            return ""
        }
        return volume
    }
    
    var timeFrame: Date {
        return _timeFrame
    }
    
    //"1. open": "101.6452",
    init(dict: [String: Any], timeStamp: Date) {
        self._open = dict["1. open"] as? String
        self._high = dict["2. high"] as? String
        self._low = dict["3. low"] as? String
        self._close = dict["4. close"] as? String
        self._volume = dict["5. volume"] as? String
        self._timeFrame = timeStamp
    }
    
    func printStuff(){
        print("Time: \(self.timeFrame) open = \(self.open) & close = \(self.close)")
    }
    
    static func getSorted(array: [Entry])->([Entry]){
        
        return array.sorted(by: { $0.timeFrame < $1.timeFrame })
        
        
    }
    
//    static var current: User {
//        guard let currentUser = _current else{
//            fatalError("Error we might be in trouble")
//        }
//        return currentUser
//    }
}
