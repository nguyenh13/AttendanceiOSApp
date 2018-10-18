//
//  Class+CoreDataProperties.swift
//  SmartAttendance
//
//  Created by Hung Nguyen on 10/18/18.
//  Copyright © 2018 Hung Nguyen. All rights reserved.
//
//

import Foundation
import CoreData


extension Class {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Class> {
        return NSFetchRequest<Class>(entityName: "Class")
    }

    @NSManaged public var class_name: String?

}
