//
//  Duty+CoreDataProperties.swift
//  Interviewing
//
//  Created by Алексей on 21.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//
//

import Foundation
import CoreData


extension Duty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Duty> {
        return NSFetchRequest<Duty>(entityName: "Duty")
    }

    @NSManaged public var id: Int32
    @NSManaged public var id_man: Int32
    @NSManaged public var name: String?
    @NSManaged public var rlDuty_man: Man?

}
