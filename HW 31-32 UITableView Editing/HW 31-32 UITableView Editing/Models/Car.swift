//
//  Car.swift
//  HW 31-32 UITableView Editing
//
//  Created by Kirill Fedorov on 22/05/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

let models = ["Volga", "Gaz", "Volvo", "Mazda"]
let years = [2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013]
let drivers = ["Vasya", "Kirill", "Petya", "Olga", "Masha", "Stas", "Kolya"]

class Car: NSObject {
    var model = String()
    var year = Int()
    var driver = String()

    class func randomCar() -> Car {
        let car = Car()
        car.model = models.randomElement() ?? "No model"
        car.year = years.randomElement()  ?? 2000
        car.driver = drivers.randomElement() ?? "No driver"
        return car
    }
    
    deinit {
        print(" CAR")
    }
}
