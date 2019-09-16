//
//  Calorie+Convenience.swift
//  Calorie Tracker
//
//  Created by Stephanie Bowles on 9/16/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation
import CoreData


extension Calorie {
    convenience init (calories: Int32, date: Date = Date(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.calories = calories
        self.date = date
    }
}
