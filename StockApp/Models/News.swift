//
//  News.swift
//  StockApp
//
//  Created by Robert Wais on 7/17/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation


struct News {
    
    init(dict: [String: Any]) {
        self._title = dict["title"] as? String
        self._pubDate = dict["pubDate"] as? String
        self._description = dict["description"] as? String
        self._content = dict["content"] as? String
    }
    
    var _title: String?
    var _pubDate: String?
    var _description: String?
    var _content: String?
    
    var title: String {
        guard let title = _title else {
            print("ERROR")
            return ""
        }
        return title
    }
    var pubDate: String {
        guard let pubDate = _pubDate else {
            print("ERROR")
            return ""
        }
        return pubDate
    }
    
    var description: String {
        guard let desc = _description else {
            print("ERROR")
            return ""
        }
        return desc
    }
    
    var content: String {
        guard let content = _content else {
            print("ERROR")
            return ""
        }
        return content
    }
}
