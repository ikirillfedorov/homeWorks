//
//  ViewController.swift
//  HW 24 Drawing Superman
//
//  Created by Kirill Fedorov on 25/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DrawingViewDelegate {
    
    var swiped     =  false
    
    // MARK: - protocole's properties
    
    var lastPoint  =  CGPoint()
    var redColor   =  CGFloat()
    var greenColor =  CGFloat()
    var blueColor  =  CGFloat()
    var opacity    =  CGFloat()
    var lineWidth  =  CGFloat()
    
    // MARK: - IBOutlet properties
    
    @IBOutlet weak var toolPanel: UIView!
    
    
    @IBOutlet weak var mainDrawingView: DrawingView!
    @IBOutlet weak var tempDrawingView: DrawingView!
    @IBOutlet weak var viewBrush: DrawingView!
    
    @IBOutlet weak var redColorValue: UILabel!
    @IBOutlet weak var greenColorValue: UILabel!
    @IBOutlet weak var blueColorValue: UILabel!
    @IBOutlet weak var opacityValue: UILabel!
    @IBOutlet weak var brushValue: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var brushSizeSlider: UISlider!
    
    // MARK: - ViewController default functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage.init(named: "image.jpg") {
            self.view.backgroundColor = UIColor.init(patternImage: image)
        }
        mainDrawingView.delegate = self
        tempDrawingView.delegate = self
        viewBrush.delegate = self
        
        refreshValues()
        
        addGestureRecognizer(direction: .down)
        addGestureRecognizer(direction: .up)
    }
    
    
    func addGestureRecognizer(direction: UISwipeGestureRecognizer.Direction) {
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipe))
        swipe.direction = direction
        swipe.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            UIView.animate(withDuration: 0.3) {
                self.toolPanel.frame.origin = CGPoint(x: 0, y: self.view.frame.maxY - self.toolPanel.frame.height)
            }
        default:
            UIView.animate(withDuration: 0.3) {
                self.toolPanel.frame.origin = CGPoint(x: 0, y: self.view.frame.maxY)
            }
        }
    }
    
    // MARK: - Helpful functions
    
    func touchEndedOrCancelled() {
        
        if !swiped {
            tempDrawingView.drawLine(from: lastPoint, to: lastPoint)
        }
        tempDrawingView.merge(tempView: tempDrawingView, intoMainView: mainDrawingView)
    }
    
    // MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        
        let touch = touches.first!
        lastPoint = touch.location(in: tempDrawingView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        
        let touch = touches.first!
        let currentPoint = touch.location(in: tempDrawingView)
        
        tempDrawingView.drawLine(from: lastPoint, to: currentPoint)
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchEndedOrCancelled()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchEndedOrCancelled()
    }
    
    // MARK: - Actions
    
    @IBAction func changeValueSlider(_ sender: AnyObject) {
        refreshValues()
    }
    
    @IBAction func erase(_ sender: AnyObject) {
        redColorSlider.value = 1
        greenColorSlider.value = 1
        blueColorSlider.value = 1
        opacitySlider.value = 1
        
        refreshValues()
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        mainDrawingView.image = nil
    }
    
    // MARK: - Refresh values
    
    func refreshValues() {
        
        redColor = CGFloat(redColorSlider.value)
        redColorValue.text = "\((Int)(redColor * 255))"
        
        greenColor = CGFloat(greenColorSlider.value)
        greenColorValue.text = "\((Int)(greenColor * 255))"
        
        blueColor = CGFloat(blueColorSlider.value)
        blueColorValue.text = "\((Int)(blueColor * 255))"
        
        opacity = CGFloat(opacitySlider.value)
        opacityValue.text = String.init(format: "%1.1f", opacity)
        
        lineWidth = CGFloat(brushSizeSlider.value * 100)
        brushValue.text = String.init(format: "%1.1f", lineWidth)
        
        viewBrush.drawPreview()
    }
    
}

