//
//  Man+CoreDataProperties.swift
//  Interviewing
//
//  Created by Алексей on 21.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//
//

import Foundation
import CoreData


extension Man {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Man> {
        return NSFetchRequest<Man>(entityName: "Man")
    }

    @NSManaged public var firstname: String?
    @NSManaged public var id: Int32
    @NSManaged public var lastname: String?
    @NSManaged public var birthday: NSDate?
    @NSManaged public var photo: NSData?
    @NSManaged public var rlMan_duty: Duty?

}
