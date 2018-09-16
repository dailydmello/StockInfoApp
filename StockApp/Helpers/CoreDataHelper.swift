//
//  CoreDataHelper.swift
//  StockApp
//
//  Created by Robert Wais on 7/18/18.
//  Copyright © 2018 MakeSchoolHackathon. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct CoreDataHelper {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate =  UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error in CoreDataHelper")
        }
        
        let persistentContainer =  appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    
    static func newPortfolio()->Portfolio {
        let portfolio = NSEntityDescription.insertNewObject(forEntityName: "Portfolio", into: context) as! Portfolio
        
        return portfolio
    }
    
    
    static func savePortfolio(){
        do{
            try context.save()
        }catch let error{
            print("Error in saving: \(error.localizedDescription)")
        }
    }
    
    static func deletePortfolio(port: Portfolio){
        context.delete(port)
        savePortfolio()
    }
    
    static func retrievePortfolio()->[Portfolio]{
        do{
            let fetchRequest = NSFetchRequest<Portfolio>(entityName:"Portfolio")
            var results = try context.fetch(fetchRequest)
            var portfolios = [Portfolio]()
            
            for index in 0..<results.count {
                portfolios.append(results[index])
            }
            return  portfolios
        }catch let error {
            print("Error: can not retrieve portfolios")
            return []
        }
    }
    
    
}
