//
//  ViewController.swift
//  HW 24 Drawing
//
//  Created by Kirill Fedorov on 24/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

   @IBOutlet var drawingView: DrawingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//MAKR - Button Get random stars
   @IBAction func getRandomStars () {
        self.drawingView.setNeedsDisplay()
    }
//MAKR - Orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.drawingView.setNeedsDisplay()
    }

}



