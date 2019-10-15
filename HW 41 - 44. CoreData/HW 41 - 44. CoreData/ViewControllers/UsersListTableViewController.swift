//
//  UsersListTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 13.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class UsersListTableViewController: UITableViewController {
    
    var users = [User]()
    var selectedUsers = [User]()
    var selectedCourse: Course!

    @IBAction func SaveStudentsBarButton(_ sender: UIBarButtonItem) {
        if selectedCourse == nil {
            print("Check error")
        } else {
            let course = CoreDataManager.shared.getCourseFromCD(course: selectedCourse)
            course?.students = NSSet(array: selectedUsers)
            CoreDataManager.shared.appdelegate.saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.isEditing = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = CoreDataManager.shared.getUsersFromCoreData()
        selectedUsers = selectedCourse.students?.allObjects as! [User]
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "reuseIdentifier")
        cell.textLabel?.text = (users[indexPath.row].firstName ?? "") + " " + (users[indexPath.row].lastName ?? "")
        cell.detailTextLabel?.text = (users[indexPath.row].email ?? "")
        
        if (selectedCourse.students?.contains(users[indexPath.row]))! {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let flag = tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none
        tableView.cellForRow(at: indexPath)?.accessoryType = flag ? .checkmark : .none

        if (selectedCourse.students?.contains(users[indexPath.row]))! {
            if let indexUserToDelete = selectedUsers.firstIndex(of: users[indexPath.row]) {
                selectedUsers.remove(at: indexUserToDelete)
                print(selectedUsers.count)
            }
        } else {
            selectedUsers.append(users[indexPath.row])
            print(selectedUsers.count)
        }
        selectedCourse.students = NSSet(array: selectedUsers)
        CoreDataManager.shared.appdelegate.saveContext()
    }
    
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if let indexUserToDelete = selectedUsers.firstIndex(of: users[indexPath.row]) {
//            selectedUsers.remove(at: indexUserToDelete)
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//
//        }
//        print(selectedUsers.count)
//    }
    
}
