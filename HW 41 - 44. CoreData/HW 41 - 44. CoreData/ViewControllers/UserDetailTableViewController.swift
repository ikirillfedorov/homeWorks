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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "userDetailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserDetailTableViewCell
        
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.label.text = "First name"
                cell.textField.placeholder = "Enter your first name"
                firstNameTextField = cell.textField
                firstNameTextField.text = editingUser?.firstName
            case 1:
                cell.label.text = "Last name"
                cell.textField.placeholder = "Enter your last name"
                lastNameTextField = cell.textField
                lastNameTextField.text = editingUser?.lastName
            default:
                cell.label.text = "Email"
                cell.textField.placeholder = "Enter your email adress"
                emailTextField = cell.textField
                emailTextField.text = editingUser?.email
            }
        }
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
