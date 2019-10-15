//
//  CoreDataManager.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 09/10/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    var appdelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var manageObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
        //MARK: - user methods
    
        //add user
        func addUserToCoreData(fisrtName: String, lastName: String, email: String) {
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: manageObjectContext) else { return }
            guard let user = NSManagedObject(entity: entityDescription, insertInto: manageObjectContext) as? User else { return }
            user.firstName = fisrtName
            user.lastName = lastName
            user.email = email
            appdelegate.saveContext()
            print("user added to core data")
        }
        
        //get users
        func getUsersFromCoreData() -> [User] {
            var result = [User]()
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            do {
                result = try manageObjectContext.fetch(fetchRequest)
                print("Users in data: \(result.count)")
            } catch {
                print(error)
            }
            return result
        }
        
        //delete user
        func deleteUser(user: User) {
            manageObjectContext.delete(user)
            appdelegate.saveContext()
        }

        //get selected user
        func getUserFromCD(user: User) -> User? {
            var result: User?
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "firstName = %@ AND lastName = %@ AND email = %@",
                                                 user.firstName ?? "",
                                                 user.lastName ?? "",
                                                 user.email ?? "")
            do {
                let data = try manageObjectContext.fetch(fetchRequest)
                print("Count object of getting data = \(data.count)")
                result = data.first
            } catch {
                print(error)
            }
            appdelegate.saveContext()
            return result
        }
    
    //MARK: - course methods
    
    func addCourseToCoreData(title: String, discipline: String, sphere: String) -> Course? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Course", in: manageObjectContext) else { return nil }
        guard let course = NSManagedObject(entity: entityDescription, insertInto: manageObjectContext) as? Course else { return nil }
        course.title = title
        course.discipline = discipline
        course.sphere = sphere
        
        appdelegate.saveContext()
        print("Course added to core data")
        return course
    }
    
    //get courses
    func getCoursesFromCoreData() -> [Course] {
        var result = [Course]()
        let fetchRequest = NSFetchRequest<Course>(entityName: "Course")
        do {
            result = try manageObjectContext.fetch(fetchRequest)
            print("Courses in data: \(result.count)")
        } catch {
            print(error)
        }
        return result
    }

//    delete course
    func deleteCourse(course: Course) {
        manageObjectContext.delete(course)
        appdelegate.saveContext()
    }
    
    //get selected course
    func getCourseFromCD(course: Course) -> Course? {
        var result: Course?
        let fetchRequest = NSFetchRequest<Course>(entityName: "Course")
        fetchRequest.predicate = NSPredicate(format: "title = %@ AND discipline = %@ AND sphere = %@",
                                             course.title ?? "",
                                             course.discipline ?? "",
                                             course.sphere ?? "")
        do {
            let data = try manageObjectContext.fetch(fetchRequest)
            print("Count object of getting data = \(data.count)")
            result = data.first
        } catch {
            print(error)
        }
        appdelegate.saveContext()
        return result
    }



}
