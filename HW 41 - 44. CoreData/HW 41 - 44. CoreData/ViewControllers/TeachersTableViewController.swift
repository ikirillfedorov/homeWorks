//
//  TeachersTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 16.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

//MARK: - Department class
class Department {
    var title: String
    var teachers: [User]
    
    init(title: String, teachers:[User]) {
        self.title = title
        self.teachers = teachers
    }
}


//MARK: - TeachersTableViewController
class TeachersTableViewController: UITableViewController {
    
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
        let coursesWithTeacher = CoreDataManager.shared.getCoursesFromCoreData().filter { $0.teacher != nil }
        print("coursesWithTeacher = \(coursesWithTeacher.count)")
        for course in coursesWithTeacher {
            if let depart = departments.first(where: { $0.title == course.sphere }) {
                depart.teachers.append(course.teacher!)
            } else {
                print("Depart created")
                departments.append(Department(title: course.sphere ?? "No sphere", teachers: [course.teacher!]))
            }
        }
        print("departments count = \(departments.count)")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(departments.count)
        return departments.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments[section].teachers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let teacher = departments[indexPath.section].teachers[indexPath.row]
        cell.textLabel?.text = (teacher.firstName ?? "") + " " + (teacher.lastName ?? "")
        cell.detailTextLabel?.text = "Number of taught courses: \(teacher.coursesTaught?.count ?? 0)"
        cell.accessoryType = .disclosureIndicator
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
