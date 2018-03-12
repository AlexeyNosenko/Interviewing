//
//  EmployeeDB.swift
//  Interviewing
//
//  Created by Алексей on 15.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import CoreData

class  ManDBCoreData {
    let connector = CoreDataConnector.coreDataConnector
    
    func save(firstname: String, lastname: String){
        print("Save...\(connector.context)")
        let entity = NSEntityDescription.entity(forEntityName: "Man", in: connector.context)!
        let man = Man.init(entity: entity, insertInto: connector.context)
        
        print("Append values")
        man.firstname = firstname
        man.lastname = lastname
        
        print("Write to contexts")
        connector.saveContext()
    }
    
    
    func getAll() -> [Man]{
        var mans = [Man]()
        do{
            let fetchRequest = NSFetchRequest<NSManagedObject>.init(entityName: "Man")
            mans = try connector.context.fetch(fetchRequest) as! [Man]
        } catch _ {
            fatalError("Dont cast to [Man]")
        }
        return mans
    }
    
    func update(id: Int, firstname: String, lastname: String){
        
    }
    
    
    func getOne(id: Int) -> Man {
        return Man()
    }
}
