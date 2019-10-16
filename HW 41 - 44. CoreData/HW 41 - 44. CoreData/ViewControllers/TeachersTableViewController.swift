//
//  TeachersTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 16.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class TeachersTableViewController: UITableViewController {
    
    var teachers = [String: [User]]()
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
        teachers.removeAll()
        let courses = CoreDataManager.shared.getCoursesFromCoreData()
        for course in courses {
            guard let teacher = course.teacher else { continue }
            if teachers[course.discipline ?? "no discipline"] == nil {
                teachers[course.discipline ?? "no discipline"] = [teacher]
            } else {
                teachers[course.discipline ?? "no discipline"]!.append(teacher)
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return teachers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        let key = Array(teachers.keys)[section]
        guard let array = teachers[key] else { return 0 }
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let key = Array(teachers.keys)[indexPath.section]
        guard let array = teachers[key] else { return cell }
        let teacher = array[indexPath.row]
        cell.textLabel?.text = (teacher.firstName ?? "") + " " + (teacher.lastName ?? "")
        cell.detailTextLabel?.text = "Number of taught courses: \(teacher.coursesTaught?.count ?? 0)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let key = Array(teachers.keys)[indexPath.section]
        guard let array = teachers[key] else { return }
        let teacher = array[indexPath.row]
        
        print("Teacher \(teacher.firstName ?? "") \(teacher.lastName ?? "") pressed")
        selectedTeacher = teacher
        performSegue(withIdentifier: "showUserDetailVC", sender: teacher)

    }

}
