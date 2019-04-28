//
//  ViewController.swift
//  HW 30 UITableView Dynamic Cells
//
//  Created by Kirill Fedorov on 28/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var students = [Student]()
    var school = [[Student]]()
    
    var mark5Students = [Student]()
    var mark4Students = [Student]()
    var mark3Students = [Student]()
    var mark2Students = [Student]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for _ in 0..<30 {
            let student = Student()
            students.append(student)
        }
        
        for student in students {
            switch student.mark {
            case 5: mark5Students.append(student)
            case 4: mark4Students.append(student)
            case 3: mark3Students.append(student)
            case 2: mark2Students.append(student)
            default:
                break
            }
            
            mark5Students.sort(by: { $0.name < $1.name })
            mark4Students.sort(by: { $0.name < $1.name })
            mark3Students.sort(by: { $0.name < $1.name })
            mark2Students.sort(by: { $0.name < $1.name })

        }
        school = [mark5Students, mark4Students, mark3Students, mark2Students]
    }
    
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return school.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            tableView.backgroundColor = .green
            return "Students with average mark 5"
        case 1:
            tableView.backgroundColor = .yellow
            return "Students with average mark 4"
        case 2:
            tableView.backgroundColor = .orange
            return "Students with average mark 3"
        case 3:
            tableView.backgroundColor = .red
            return "Students with average mark 2"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return school[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "Cell"
        var cell: UITableViewCell
        
        if let tempCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            cell = tempCell
        } else {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: identifier)
        }
        
        cell.textLabel?.text = school[indexPath.section][indexPath.row].fullName
        cell.detailTextLabel?.text = String(school[indexPath.section][indexPath.row].mark)
        return cell
    }
    
}

//MARK: - Helpful functions
func getRandomColor() -> UIColor {
    return UIColor(red: .random(in: 0...1),
                   green: .random(in: 0...1),
                   blue: .random(in: 0...1),
                   alpha: 1.0)
}

func getStringFrom(color:UIColor?) -> String {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    if let newColor = color {
        newColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return "R = \(Int(red * 255)) G = \(Int(green * 255)) B = \(Int(blue * 255))"
    } else {
        return "No color"
    }
}


