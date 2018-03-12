//
//  CoreDataConnector.swift
//  Interviewing
//
//  Created by Алексей on 11.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit
import CoreData

class CoreDataConnector: DBConnector {
    static let coreDataConnector = CoreDataConnector()
    
    private init(){
        
    }
    
    let containerName = "CoreDataModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func saveContext(){
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
