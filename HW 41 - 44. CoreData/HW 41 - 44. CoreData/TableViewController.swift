//
//  TableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 05/10/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var manageObjectContext: NSManagedObjectContext!
    var appdelegate: AppDelegate!
    var users = [User]()
    
    @IBOutlet weak var usersTableView: UITableView!
    
    @IBAction func addUserBarButton(_ sender: UIBarButtonItem) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: manageObjectContext) else { return }
        guard let user = NSManagedObject(entity: entityDescription, insertInto: manageObjectContext) as? User else { return }
        user.firstName = "KIRILL"
        user.lastName = "FEDOROV"
        user.email = "ikirillfedorov@gmail.com"
        appdelegate.saveContext()
        
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        do {
            users = try manageObjectContext.fetch(fetchRequest)
            print("Usrs = \(users.count)")
            usersTableView.reloadData()
        } catch {
            print(error)
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appdelegate = (UIApplication.shared.delegate as! AppDelegate)
        manageObjectContext = appdelegate.persistentContainer.viewContext
        
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
        
        cell.textLabel?.text = users[indexPath.row].firstName
        cell.detailTextLabel?.text = users[indexPath.row].lastName

        return cell
    }

}
