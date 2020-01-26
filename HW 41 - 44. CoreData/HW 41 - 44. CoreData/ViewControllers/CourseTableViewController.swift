//
//  CourseTableViewController.swift
//  HW 41 - 44. CoreData
//
//  Created by Kirill Fedorov on 09/10/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit
import CoreData

class CourseTableViewController: UITableViewController {
    
    var selectedCourse: Course?
    var courses = [Course]()

    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
        selectedCourse = nil
        showCourseDetailVC()
    }
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Courses"
        courses = CoreDataManager.shared.getCoursesFromCoreData()
        tableView.reloadData()
    }

    //MARK: - help functions
    func showCourseDetailVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let courseDetailVC = storyboard.instantiateViewController(identifier: "courseDetailTableViewController")
        courseDetailVC.title = selectedCourse == nil ? "New course" : (selectedCourse?.title ?? "") + " " + (selectedCourse?.discipline ?? "")
        navigationController?.pushViewController(courseDetailVC, animated: true)
    }

    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseidentifier = "courseCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseidentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseidentifier)

        // Configure the cell...
        cell.textLabel?.text = (courses[indexPath.row].title ?? "") + " " + (courses[indexPath.row].discipline ?? "")
        cell.detailTextLabel?.text = courses[indexPath.row].sphere
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            let courseToDelete = courses.remove(at: indexPath.row)
            CoreDataManager.shared.deleteCourse(course: courseToDelete)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCourse = courses[indexPath.row]
        showCourseDetailVC()
    }

}
