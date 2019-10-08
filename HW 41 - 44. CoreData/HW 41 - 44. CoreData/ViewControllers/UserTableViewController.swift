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
    
    var manageObjectContext: NSManagedObjectContext!
    var appdelegate: AppDelegate!
    var selectedUser: User?
    var users = [User]()
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBAction func addUserBarButton(_ sender: UIBarButtonItem) {
//        addUserToCoreData(fisrtName: "VASA", lastName: "PETROV", email: "123@mail.ru")
//        users = getUsersFromCoreData()
//        usersTableView.reloadData()
        selectedUser = nil
        showUserDetailVC()
        
//        self.present(userDetailVC, animated: true, completion: nil)
    }
    
    //MARK: - help functions
    
    
    //Show user datail vc
    func showUserDetailVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userDetailVC = storyboard.instantiateViewController(identifier: "userDetailTableViewController")
        userDetailVC.title = selectedUser == nil ? "New user" : (selectedUser?.firstName ?? "") + " " + (selectedUser?.lastName ?? "")
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
    
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
    
    //get data
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
    
    //delete
    func delete(user: User) {
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
    
    //ViewController life
    override func viewDidLoad() {
        super.viewDidLoad()
        appdelegate = (UIApplication.shared.delegate as! AppDelegate)
        manageObjectContext = appdelegate.persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        users = getUsersFromCoreData()
        usersTableView.reloadData()
    }

    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return users.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = (users[indexPath.row].firstName ?? "") + " " + (users[indexPath.row].lastName ?? "")
        cell.detailTextLabel?.text = users[indexPath.row].email
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            usersTableView.beginUpdates()
            tableView.deleteRows(at: [indexPath ], with: .automatic)
            let userToDelete = users.remove(at: indexPath.row)
            delete(user: userToDelete)
            usersTableView.endUpdates()

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedUser = users[indexPath.row]
        
        showUserDetailVC()
        
    }

}
