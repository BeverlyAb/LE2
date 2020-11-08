//
//  Persistence.swift
//  LE2
//
//  Created by Beverly on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

import CoreData

struct PersistentController {
    static let shared = PersistentController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (_,error)in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error),\(error.userInfo)")
            }
        }
    }
}
