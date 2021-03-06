//
//  TeachersListTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 14.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class TeachersListTableViewController: UITableViewController {
    
    var selectedCourse: Course?
    var selectedTeacher: User?
    var teachers = [User]()
    
    @IBAction func saveTeacherBarButton(_ sender: UIBarButtonItem) {
        print("saveTeacherBarButton pressed")
        
        selectedCourse?.teacher = selectedTeacher
        CoreDataManager.shared.appdelegate.saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teachers = CoreDataManager.shared.getUsersFromCoreData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teachers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = (teachers[indexPath.row].firstName ?? "") + " " + (teachers[indexPath.row].lastName ?? "")
        cell.detailTextLabel?.text = teachers[indexPath.row].email
        if teachers[indexPath.row] == selectedTeacher {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell.accessoryType == .checkmark {
            selectedTeacher = nil
        } else {
            selectedTeacher = teachers[indexPath.row]
        }
        tableView.reloadData()
    }


}
