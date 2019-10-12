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
    
    var students: [User]?
    var editingCourse: Course?
    
    
    var courseVC: CourseTableViewController!
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        
        if editingCourse == nil {
            CoreDataManager.shared.addCourseToCoreData(title: titleTextField.text ?? "",
                                                       discipline: disciplineTextField.text ?? "",
                                                       sphere: sphereTextField.text ?? "")
        } else {
            guard let updatingCourse = CoreDataManager.shared.getCourseFromCD(course: editingCourse!) else { return }
            updatingCourse.title = titleTextField.text ?? ""
            updatingCourse.discipline = disciplineTextField.text ?? ""
            updatingCourse.sphere = sphereTextField.text ?? ""
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Students of course"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 3
        } else {
            return editingCourse?.students?.count ?? 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "courseDetailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CourseDetailTableViewCell
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.label.text = "Title"
                cell.textField.placeholder = "Enter title of course"
                titleTextField = cell.textField
                titleTextField.text = editingCourse?.title
            case 1:
                cell.label.text = "Discipline"
                cell.textField.placeholder = "Enter discipline of course"
                disciplineTextField = cell.textField
                disciplineTextField.text = editingCourse?.discipline
            default:
                cell.label.text = "Sphere"
                cell.textField.placeholder = "Enter sphere of course"
                sphereTextField = cell.textField
                sphereTextField.text = editingCourse?.sphere
            }
        } else if indexPath.section == 1 {
            
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
