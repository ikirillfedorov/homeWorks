//
//  TeachersTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 16.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class TeachersTableViewController: UITableViewController {
    
    class Department {
        var title: String
        var teachers: [User]
        
        init(title: String, teachers:[User]) {
            self.title = title
            self.teachers = teachers
        }
    }
    
    var departments = [Department]()
    var selectedTeacher: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetailVC" {
            let vc = segue.destination as! UserDetailTableViewController
            vc.title = ((sender as! User).firstName ?? "") + " " + ((sender as! User).lastName ?? "")
            vc.editingUser = (sender as! User)
        }
    }


    //MARK: - Help functions
    private func updateData() {
        departments.removeAll()
        let courses = CoreDataManager.shared.getCoursesFromCoreData()
        for course in courses {
            guard let teacher = course.teacher else { return }
            let departs = departments.filter { $0.title == course.sphere }
            if let depart = departs.first {
                depart.teachers.append(teacher)
            } else {
                departments.append(Department(title: course.sphere ?? "No sphere", teachers: [teacher]))

            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return departments.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return departments[section].teachers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let teacher = departments[indexPath.section].teachers[indexPath.row]
        cell.textLabel?.text = (teacher.firstName ?? "") + " " + (teacher.lastName ?? "")
        cell.detailTextLabel?.text = "Number of taught courses: \(teacher.coursesTaught?.count ?? 0)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let teacher = departments[indexPath.section].teachers[indexPath.row]

        print("Teacher \(teacher.firstName ?? "") \(teacher.lastName ?? "") pressed")
        selectedTeacher = teacher
        performSegue(withIdentifier: "showUserDetailVC", sender: teacher)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return departments[section].title
    }

}
