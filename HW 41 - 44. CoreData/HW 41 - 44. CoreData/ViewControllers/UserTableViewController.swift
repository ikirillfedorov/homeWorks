//
//  TableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 05/10/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit
import CoreData

class UserTableViewController: UITableViewController {
    
    var selectedUser: User?
    var users = [User]()
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBAction func addUserBarButton(_ sender: UIBarButtonItem) {
        selectedUser = nil
        showUserDetailVC()
    }
    
    //MARK: - help functions
    
    //Show user datail vc
    func showUserDetailVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userDetailVC = storyboard.instantiateViewController(identifier: "userDetailTableViewController")
        userDetailVC.title = selectedUser == nil ? "New user" : (selectedUser?.firstName ?? "") + " " + (selectedUser?.lastName ?? "")
        navigationController?.pushViewController(userDetailVC, animated: true)
    }

    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        users = CoreDataManager.shared.getUsersFromCoreData()
        usersTableView.reloadData()
    }

    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return users.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseidentifier = "userCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseidentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseidentifier)
        
        cell.textLabel?.text = (users[indexPath.row].firstName ?? "") + " " + (users[indexPath.row].lastName ?? "")
        cell.detailTextLabel?.text = users[indexPath.row].email
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            usersTableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let userToDelete = users.remove(at: indexPath.row)
            CoreDataManager.shared.deleteUser(user: userToDelete)
            usersTableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedUser = users[indexPath.row]
        showUserDetailVC()
    }
}

