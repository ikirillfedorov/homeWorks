//
//  Garage.swift
//  HW 31-32 UITableView Editing
//
//  Created by Kirill Fedorov on 25/05/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class Garage {
    
    var name: String
    var cars: [Car]
    
    init(name: String, cars: [Car]) {
        self.name = name
        self.cars = cars
    }

    deinit {
        print("DEALLOCEATED GARAGE")
    }

}
