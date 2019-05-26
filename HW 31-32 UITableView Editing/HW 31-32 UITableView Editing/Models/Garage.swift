//
//  Garage.swift
//  HW 31-32 UITableView Editing
//
//  Created by Kirill Fedorov on 25/05/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class Garage: NSObject {
    
    var name: String!
    var cars: [Car]!

    deinit {
        print("DEALLOCEATED GARAGE")
    }

}
