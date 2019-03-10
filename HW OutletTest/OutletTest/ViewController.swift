//
//  ViewController.swift
//  OutletTest
//
//  Created by Kirill Fedorov on 08/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

var blackCheckers = [UIView]()

class ViewController: UIViewController {
    
    @IBOutlet weak var field: UIView!
    @IBOutlet var cells: [UIView]!
    @IBOutlet var checkers: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for cell in cells {
            if cell.backgroundColor == .black {
                blackCheckers.append(cell)
            }
        }
        
    }
    
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        
        let randomColor =  UIColor(red: CGFloat.random(in: 0...1),
                                   green: CGFloat.random(in: 0...1),
                                   blue: CGFloat.random(in: 0...1),
                                   alpha: 1)
        
        for checker in blackCheckers {
            checker.backgroundColor = randomColor
        }
        
        let randomCountChange = (Int.random(in: 0...Int.max) % self.checkers.count / 2) + 1
        
        UIView.animate(withDuration: 1) {
            
            for _ in 0...randomCountChange {
                let firstChecker = self.checkers[Int.random(in: 0..<self.checkers.count)]
                let secondChecker = self.checkers[Int.random(in: 0..<self.checkers.count)]
                
                let tempRect = firstChecker.frame
                firstChecker.frame = secondChecker.frame
                secondChecker.frame = tempRect
                
                self.field.bringSubviewToFront(firstChecker)
                self.field.bringSubviewToFront(secondChecker)
            }
        }
    }
}


