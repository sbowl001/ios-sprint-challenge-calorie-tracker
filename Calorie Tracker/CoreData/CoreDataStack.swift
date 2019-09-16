//
//  CoreDataStack.swift
//  Calorie Tracker
//
//  Created by Stephanie Bowles on 9/16/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CalorieTracker")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Failed to load from persistent store: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
                
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error {throw error}
    }
}
