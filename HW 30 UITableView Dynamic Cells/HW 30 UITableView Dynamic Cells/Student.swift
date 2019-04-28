//
//  Student.swift
//  HW 30 UITableView Dynamic Cells
//
//  Created by Kirill Fedorov on 28/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class Student: NSObject {
    let name: String
    let lastName: String
    var fullName: String {
        return "\(name)" + " " + "\(lastName)"
    }
    let mark = Int.random(in: 1...5)
    
    private let names = ["Kirill", "Petya", "Vasya", "Oleg", "Kolya", "Alex"]
    private let lastNames = ["Petrov", "Ivanov", "Sidorov", "Fedorov", "Tkachev"]

    override init() {
        self.name = names[Int.random(in: 0...names.count - 1)]
        self.lastName = lastNames[Int.random(in: 0...lastNames.count - 1)]
    }
    
}
