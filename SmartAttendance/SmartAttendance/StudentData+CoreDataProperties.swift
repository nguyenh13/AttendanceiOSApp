//
//  StudentData+CoreDataProperties.swift
//  SmartAttendance
//
//  Created by Hung Nguyen on 11/7/18.
//  Copyright © 2018 Hung Nguyen. All rights reserved.
//
//

import Foundation
import CoreData


extension StudentData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentData> {
        return NSFetchRequest<StudentData>(entityName: "StudentData")
    }

    @NSManaged public var student_name: String?

}
