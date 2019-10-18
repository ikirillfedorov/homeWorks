//
//  CourseDetailTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 11.10.2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class CourseDetailTableViewController: UITableViewController {

    var titleTextField: UITextField!
    var disciplineTextField: UITextField!
    var sphereTextField: UITextField!
    
    var students = [User]()
    var editingCourse: Course?
    var teacher: User?
    
    var courseVC: CourseTableViewController!
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        
        if editingCourse == nil {
            editingCourse = CoreDataManager.shared.addCourseToCoreData(title: titleTextField.text ?? "No title",
                                                       discipline: disciplineTextField.text ?? "No discipline",
                                                       sphere: sphereTextField.text ?? "No sphere")
        } else {
            guard let updatingCourse = CoreDataManager.shared.getCourseFromCD(course: editingCourse!) else { return }
            updatingCourse.title = titleTextField.text ?? "No title"
            updatingCourse.discipline = disciplineTextField.text ?? "No discipline"
            updatingCourse.sphere = sphereTextField.text ?? "No sphere"
        }
        
        editingCourse = nil
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let controllers = navigationController?.viewControllers else { return }
        courseVC = controllers[controllers.count - 2] as? CourseTableViewController
        editingCourse = courseVC.selectedCourse
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        //set students from editingcourse.students
        if let courseStudents = editingCourse?.students?.allObjects as? [User] {
            students = courseStudents
        }
        teacher = editingCourse?.teacher
        tableView.reloadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetailVC" {
            let vc = segue.destination as! UserDetailTableViewController
            vc.editingUser = (sender as! User)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Course info"
        case 1:
            return "Students of course"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 4
        } else {
            return students.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let courseCellIdentifier = "courseDetailCell"
        let usersCellIdentifier = "usersCellIdentifier"
        
        var cell = UITableViewCell()

        let courseInfoCell = tableView.dequeueReusableCell(withIdentifier: courseCellIdentifier, for: indexPath) as! CourseDetailTableViewCell
        let userCell = tableView.dequeueReusableCell(withIdentifier: usersCellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: usersCellIdentifier)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                courseInfoCell.label.text = "Title"
                courseInfoCell.textField.placeholder = "Enter title of course"
                titleTextField = courseInfoCell.textField
                titleTextField.text = editingCourse?.title
            case 1:
                courseInfoCell.label.text = "Discipline"
                courseInfoCell.textField.placeholder = "Enter discipline of course"
                disciplineTextField = courseInfoCell.textField
                disciplineTextField.text = editingCourse?.discipline
            case 2:
                courseInfoCell.label.text = "Sphere"
                courseInfoCell.textField.placeholder = "Enter sphere of course"
                sphereTextField = courseInfoCell.textField
                sphereTextField.text = editingCourse?.sphere
            default:
                let teacherCell = tableView.dequeueReusableCell(withIdentifier: "teacherCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "teacherCell")
                teacherCell.textLabel?.text = " Teacher"
                teacherCell.detailTextLabel?.text = teacher == nil ? "Choose teacher" : (teacher?.firstName ?? "") + " " + (teacher?.lastName ?? "")

                return teacherCell
            }
            cell = courseInfoCell
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let systemCell = tableView.dequeueReusableCell(withIdentifier: "systemCell") ?? UITableViewCell(style: .default, reuseIdentifier: "systemCell")
                systemCell.textLabel?.text = "Add student"
                systemCell.textLabel?.textAlignment = .center
                return systemCell
            } else {
                userCell.textLabel?.text = (students[indexPath.row - 1].firstName ?? "") + " " + (students[indexPath.row - 1].lastName ?? "")
                userCell.detailTextLabel?.text = (students[indexPath.row - 1].email ?? "")
                userCell.accessoryType = .disclosureIndicator
            }
            cell = userCell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if editingCourse == nil {
            editingCourse = CoreDataManager.shared.addCourseToCoreData(title: titleTextField.text ?? "",
                                                       discipline: disciplineTextField.text ?? "",
                                                       sphere: sphereTextField.text ?? "")
        }

        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 3:
                print("Teacher cell pressed")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let teachersListVC = storyboard.instantiateViewController(identifier: "teachersListTableViewController") as! TeachersListTableViewController
                teachersListVC.selectedCourse = editingCourse
                teachersListVC.selectedTeacher = teacher
                navigationController?.pushViewController(teachersListVC, animated: true)
            default:
                break
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                //do somthing
                print("System cell pressed")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let userListVC = storyboard.instantiateViewController(identifier: "usersListTableViewController") as! UsersListTableViewController
                userListVC.selectedCourse = editingCourse
                navigationController?.pushViewController(userListVC, animated: true)
            } else {
                let selectedUser = students[indexPath.row - 1]
                performSegue(withIdentifier: "showUserDetailVC", sender: selectedUser)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            let studentToDelete = students.remove(at: indexPath.row - 1)
            guard let course = editingCourse else { return }
            course.removeFromStudents(studentToDelete)
            tableView.endUpdates()
        }
    }
}

extension CourseDetailTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
