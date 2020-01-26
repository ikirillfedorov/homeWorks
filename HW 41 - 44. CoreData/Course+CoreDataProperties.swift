//
//  Course+CoreDataProperties.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 15.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var discipline: String?
    @NSManaged public var sphere: String?
    @NSManaged public var title: String?
    @NSManaged public var students: NSSet?
    @NSManaged public var teacher: User?

}

// MARK: Generated accessors for students
extension Course {

    @objc(addStudentsObject:)
    @NSManaged public func addToStudents(_ value: User)

    @objc(removeStudentsObject:)
    @NSManaged public func removeFromStudents(_ value: User)

    @objc(addStudents:)
    @NSManaged public func addToStudents(_ values: NSSet)

    @objc(removeStudents:)
    @NSManaged public func removeFromStudents(_ values: NSSet)

}
