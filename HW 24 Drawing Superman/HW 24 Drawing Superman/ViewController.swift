//
//  ViewController.swift
//  HW 24 Drawing Superman
//
//  Created by Kirill Fedorov on 25/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var hasActiveSwipeAction = false
    
    // MARK: - DrawingViewDelegate
    
    var lastPoint = CGPoint()
    
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
        if let image = UIImage(named: "image.jpg") {
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        mainDrawingView.dataSource = self
        tempDrawingView.dataSource = self
        viewBrush.dataSource = self
        
        refreshValues()
        
        addSwipeRecognizer(direction: .down)
        addSwipeRecognizer(direction: .up)
    }
    
    
    func addSwipeRecognizer(direction: UISwipeGestureRecognizer.Direction) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
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
        case .down:
            UIView.animate(withDuration: 0.3) {
                self.toolPanel.frame.origin = CGPoint(x: 0, y: self.view.frame.maxY)
            }
        default:
            break
        }
    }
    
    // MARK: - Helpful functions
    
    func touchEndedOrCancelled() {
        
        if !hasActiveSwipeAction {
            tempDrawingView.drawLine(from: lastPoint, to: lastPoint)
        }
        tempDrawingView.merge(tempView: tempDrawingView, intoMainView: mainDrawingView)
    }
    
    // MARK: - Touches
    
    func getLocation(from touches: Set<UITouch>) -> CGPoint? {
        var location: CGPoint? = nil
        if let touch =  touches.first {
            location = touch.location(in: tempDrawingView)
        }
        return location
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hasActiveSwipeAction = false
        lastPoint = getLocation(from: touches) ?? lastPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hasActiveSwipeAction = true
        
        guard let currentPoint = getLocation(from: touches) else { return }
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
        redColorValue.text = "\(Int(redColorSlider.value * Float(255.0)))"
        greenColorValue.text = "\(Int(greenColorSlider.value * Float(255.0)))"
        blueColorValue.text = "\(Int(blueColorSlider.value * Float(255.0)))"
        opacityValue.text = String(format: "%1.1f", opacitySlider.value)
        brushValue.text = String(format: "%1.1f", brushSizeSlider.value)
        
        viewBrush.drawPreview()
    }
}

extension ViewController: DrawingViewDrawingParametersSource {
    var opacity: CGFloat {
        return CGFloat(opacitySlider.value)
    }
    
    var lineWidth: CGFloat {
        return CGFloat(brushSizeSlider.value * 100)
    }
    
    var color: CGColor {
        return UIColor(red: CGFloat(redColorSlider.value),
                       green: CGFloat(greenColorSlider.value),
                       blue: CGFloat(blueColorSlider.value),
                       alpha: CGFloat(opacitySlider.value)).cgColor
    }
}


