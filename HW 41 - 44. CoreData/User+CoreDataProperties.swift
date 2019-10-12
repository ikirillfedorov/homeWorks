//
//  User+CoreDataProperties.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 11.10.2019.
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

}
