//
//  ViewController.swift
//  HW 35 UITableView Search
//
//  Created by Kirill Fedorov on 02/09/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current

    var students = [Student]()
    var sectionsArray = [Section]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortTypeSegmentControl: UISegmentedControl!
    
    func generateSections(arr: [Student], filterString: String?, sortType: Int) {
        switch sortType {
        case 0: //sort by first name
            self.sectionsArray = generateSectionsFromArrayByFirstName(arr: students, filterString: searchBar.text)
        case 1: //sort by last name
            self.sectionsArray = generateSectionsFromArrayByLastName(arr: students, filterString: searchBar.text)
        case 2: //sort by birth date
            self.sectionsArray = generateSectionsFromArrayByMonth(arr: students, filterString: searchBar.text)
        default:
            break
        }
        tableView.reloadData()
    }
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        generateSections(arr: students, filterString: searchBar.text, sortType: sender.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        dateFormatter.dateStyle = .medium
        
        for _ in 0..<1000 {
            students.append(Student.createStudent())
        }
        
        self.sectionsArray = generateSectionsFromArrayByFirstName(arr: students, filterString: searchBar.text)
    }

    //MARK: - support functions
    func sortArrayByMonth(studentsArray: [Student]) -> [Student] {
        var sortedStudents = studentsArray.sorted { (student1, student2) -> Bool in
            student1.birthDate < student2.birthDate
            
//            if student1.firstName != student2.firstName {
//                return student1.firstName < student2.firstName
//            } else {
//                return student1.lastName < student2.lastName
//            }
        }
        
        
        sortedStudents.sort { (student1, student2) -> Bool in
            calendar.component(.month, from: student1.birthDate) < calendar.component(.month, from: student2.birthDate)
        }
        return sortedStudents
    }

    func generateSectionsFromArrayByFirstName(arr: [Student], filterString: String?) -> [Section] {
        let students = arr.sorted { (student1, student2) -> Bool in
            student1.firstName < student2.firstName
        }
        
        var currentLetter = ""
        var secionArr = [Section]()
        
        for student in students {
            if filterString != "" && !(student.firstName + student.lastName).contains(filterString ?? "")  {
                continue
            }
            
            let studentLetter = String(student.firstName.prefix(1))
            var section = Section()
            
            if currentLetter != studentLetter {
                currentLetter = studentLetter
                section.sectionName = currentLetter
                secionArr.append(section)
            } else {
                guard let lastSection = secionArr.last else { continue }
                section = lastSection
            }
            section.itemsArray.append(student)
        }
        return secionArr
    }
    
    func generateSectionsFromArrayByLastName(arr: [Student], filterString: String?) -> [Section] {
        let students = arr.sorted { (student1, student2) -> Bool in
            student1.lastName < student2.lastName
        }
        
        var currentLetter = ""
        var secionArr = [Section]()
        
        for student in students {
            if filterString != "" && !(student.firstName + student.lastName).contains(filterString ?? "")  {
                continue
            }
            
            let studentLetter = String(student.lastName.prefix(1))
            var section = Section()
            
            if currentLetter != studentLetter {
                currentLetter = studentLetter
                section.sectionName = currentLetter
                secionArr.append(section)
            } else {
                guard let lastSection = secionArr.last else { continue }
                section = lastSection
            }
            section.itemsArray.append(student)
        }
        return secionArr
    }

    func generateSectionsFromArrayByMonth(arr: [Student], filterString: String?) -> [Section] {
        let students = sortArrayByMonth(studentsArray: arr)
        let calendar = Calendar.current
        var currentMonth = 0
        var secionArr = [Section]()
        
        for student in students {
            if filterString != "" && !(student.firstName + student.lastName).contains(filterString ?? "")  {
                continue
            }
            
            let studentMonth = calendar.component(.month, from: student.birthDate)
            var section = Section()
            
            if currentMonth != studentMonth {
                let month = student.birthDate
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM"
                let nameOfMonth = dateFormatter.string(from: month)
                section.sectionName = nameOfMonth
                currentMonth = studentMonth
                secionArr.append(section)
            } else {
                guard let lastSection = secionArr.last else { continue }
                section = lastSection
            }
            section.itemsArray.append(student)
        }
        return secionArr
    }
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        generateSections(arr: students, filterString: searchBar.text, sortType: sortTypeSegmentControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}


//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var array = [String]()
        
        for sec in sectionsArray {
            array.append(sec.sectionName)
        }
        return array
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsArray[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsArray[section].itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .value1, reuseIdentifier: identifier)
        
        cell.textLabel?.text = sectionsArray[indexPath.section].itemsArray[indexPath.row].firstName + " " + sectionsArray[indexPath.section].itemsArray[indexPath.row].lastName
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: sectionsArray[indexPath.section].itemsArray[indexPath.row].birthDate))"
        
        return cell
    }
}
