//
//  TestClass.swift
//  HW 30 UITableView Dynamic Cells
//
//  Created by Kirill Fedorov on 28/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class TestClass: NSObject {
    var name: String
    var color: UIColor
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}


//func createObjects(count:Int) -> [TestClass] {
//    var objects = [TestClass]()
//    
//    for i in 0...100 {
//        let object = TestClass(name: "object#\(i)", color: getRandomColor())
//        objects.append(object)
//    }
//    return objects
//}

