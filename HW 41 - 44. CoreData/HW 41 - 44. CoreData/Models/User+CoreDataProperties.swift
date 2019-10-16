//
//  User+CoreDataProperties.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 15.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var courses: NSSet?
    @NSManaged public var coursesTaught: NSSet?

}

// MARK: Generated accessors for courses
extension User {

    @objc(addCoursesObject:)
    @NSManaged public func addToCourses(_ value: Course)

    @objc(removeCoursesObject:)
    @NSManaged public func removeFromCourses(_ value: Course)

    @objc(addCourses:)
    @NSManaged public func addToCourses(_ values: NSSet)

    @objc(removeCourses:)
    @NSManaged public func removeFromCourses(_ values: NSSet)

}

// MARK: Generated accessors for coursesTaught
extension User {

    @objc(addCoursesTaughtObject:)
    @NSManaged public func addToCoursesTaught(_ value: Course)

    @objc(removeCoursesTaughtObject:)
    @NSManaged public func removeFromCoursesTaught(_ value: Course)

    @objc(addCoursesTaught:)
    @NSManaged public func addToCoursesTaught(_ values: NSSet)

    @objc(removeCoursesTaught:)
    @NSManaged public func removeFromCoursesTaught(_ values: NSSet)

}
