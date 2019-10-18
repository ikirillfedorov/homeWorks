//
//  UserDetailTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 05/10/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class UserDetailTableViewController: UITableViewController {
    
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var emailTextField: UITextField!
    var editingUser: User?
    var learningCourses = [Course]()
    var taughtCourses = [Course]()

    
    var userVC: UserTableViewController?

    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {

        if editingUser == nil {
            CoreDataManager.shared.addUserToCoreData(fisrtName: firstNameTextField.text ?? "",
                                                     lastName: lastNameTextField.text ?? "",
                                                     email: emailTextField.text ?? "")
        } else {
            guard let updatingUser = CoreDataManager.shared.getUserFromCD(user: editingUser!) else { return }
            updatingUser.firstName = firstNameTextField.text ?? ""
            updatingUser.lastName = lastNameTextField.text ?? ""
            updatingUser.email = emailTextField.text ?? ""
            editingUser = nil
        }
        
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let controllers = navigationController?.viewControllers else { return }
        if let userVC = controllers[controllers.count - 2] as? UserTableViewController {
            editingUser = userVC.selectedUser
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if editingUser != nil {
            learningCourses = editingUser?.courses?.allObjects as! [Course]
            taughtCourses = editingUser?.coursesTaught?.allObjects as! [Course]
        }
        print(taughtCourses.count)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return editingUser?.courses?.count ?? 0
        default:
            return editingUser?.coursesTaught?.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "userDetailCell"
        let userCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserDetailTableViewCell
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                userCell.label.text = "First name"
                userCell.textField.placeholder = "Enter your first name"
                firstNameTextField = userCell.textField
                firstNameTextField.text = editingUser?.firstName
            case 1:
                userCell.label.text = "Last name"
                userCell.textField.placeholder = "Enter your last name"
                lastNameTextField = userCell.textField
                lastNameTextField.text = editingUser?.lastName
            default:
                userCell.label.text = "Email"
                userCell.textField.placeholder = "Enter your email adress"
                emailTextField = userCell.textField
                emailTextField.text = editingUser?.email
            }
            cell = userCell
        case 1:
            let learningCoursCell = tableView.dequeueReusableCell(withIdentifier: "learningCoursCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "learningCoursCell")
            learningCoursCell.textLabel?.text = (learningCourses[indexPath.row].title ?? "") + " " + (learningCourses[indexPath.row].discipline ?? "")
            learningCoursCell.detailTextLabel?.text = learningCourses[indexPath.row].sphere ?? ""
            cell = learningCoursCell
        case 2:
            let taughtCourseCell = tableView.dequeueReusableCell(withIdentifier: "taughtCourseCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "taughtCourseCell")
            taughtCourseCell.textLabel?.text = (taughtCourses[indexPath.row].title ?? "") + " " + (taughtCourses[indexPath.row].discipline ?? "")
            taughtCourseCell.detailTextLabel?.text = taughtCourses[indexPath.row].sphere ?? ""
            cell = taughtCourseCell
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //tableView.numberOfRows(inSection: section) not work :(
        switch section {
        case 0:
            return "User info"
        case 1:
            guard let numberOfLearningCourses = editingUser?.courses?.count else { return nil }
            return numberOfLearningCourses == 0 ? nil : "Learning courses"
        default:
            guard let numberOfCoursesTaught = editingUser?.coursesTaught?.count else { return nil }
            return numberOfCoursesTaught == 0 ? nil : "Taught courses"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserDetailTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
