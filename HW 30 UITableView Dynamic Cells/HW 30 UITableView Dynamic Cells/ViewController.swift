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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
            var objects = [TestClass]()
            
            for i in 0...1000 {
                let object = TestClass(name: "object#\(i)", color: getRandomColor())
                objects.append(object)
        }
    }


}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("row = \(indexPath.row)")
        print("section = \(indexPath.section)")

        let identifier = "Cell"
        var cell: UITableViewCell
        
        if let tempCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            print("Cell Reusable")
            cell = tempCell
        } else {
            print("Cell Crated")
            cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        
        cell.backgroundColor = getRandomColor()
        cell.textLabel?.text = getStringFrom(color: cell.backgroundColor)
        cell.textLabel?.textAlignment = .center
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


