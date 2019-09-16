//
//  CalorieController.swift
//  Calorie Tracker
//
//  Created by Stephanie Bowles on 9/16/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation
import CoreData


class CalorieController {
    
    var calories: [Calorie] = []
//    {
//        let fetchRequest: NSFetchRequest<Calorie> =
//        Calorie.fetchRequest()
//        let moc = CoreDataStack.shared.mainContext
//
//        do {
//            return try moc.fetch(fetchRequest)
//        } catch {
//            NSLog("error fetching calorie")
//            return []
//        }
//    }
    
    func addCalories(with amount: String){
        guard let amount = Int32(amount) else {return}
       //changing to int for coredata
        let calorie = Calorie(calories: amount)
//        Calorie(calories: amount)
        calories.append(calorie)
//        calories.append(calorie)
        
        do {
            try CoreDataStack.shared.saveToPersistentStore()
        } catch {
            NSLog("Error saving Calorie: \(error)")
        }
        
    }
}
