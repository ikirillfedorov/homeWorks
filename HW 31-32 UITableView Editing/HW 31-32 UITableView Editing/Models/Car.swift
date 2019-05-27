//
//  Car.swift
//  HW 31-32 UITableView Editing
//
//  Created by Kirill Fedorov on 22/05/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

private let models = ["Volga", "Gaz", "Volvo", "Mazda"]
private let years = [2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013]
private let drivers = ["Vasya", "Kirill", "Petya", "Olga", "Masha", "Stas", "Kolya"]

class Car {
    var model: String
    var year: Int
    var driver: String
    
    init() {
        self.model = models.randomElement() ?? "No model"
        self.year = years.randomElement()  ?? 2000
        self.driver = drivers.randomElement() ?? "No driver"
    }
}
