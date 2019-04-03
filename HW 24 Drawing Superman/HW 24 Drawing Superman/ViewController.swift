//
//  ViewController.swift
//  HW 24 Drawing Superman
//
//  Created by Kirill Fedorov on 25/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

extension ViewController: DrawingViewColorSource {
}

class ViewController: UIViewController {
    
    var hasActiveSwipeAction = false
    
    // MARK: - DrawingViewDelegate
    
    var lastPoint = CGPoint()
    var redColorSaturation = CGFloat()
    var greenColorSaturation = CGFloat()
    var blueColorSaturation = CGFloat()
    var opacity = CGFloat()
    var lineWidth = CGFloat()
    
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
        mainDrawingView.delegate = self
        tempDrawingView.delegate = self
        viewBrush.delegate = self
        
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
    
    func getTouch(from touches: Set<UITouch>) -> UITouch? {
        if let touch = touches.first {
            return touch
        } else {
            return nil
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hasActiveSwipeAction = false
        
        guard let touch = getTouch(from: touches) else { return }
        lastPoint = touch.location(in: tempDrawingView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hasActiveSwipeAction = true
        
        guard let touch = getTouch(from: touches) else { return }
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
        
        redColorSaturation = CGFloat(redColorSlider.value)
        redColorValue.text = "\((Int)(redColorSaturation * 255))"
        
        greenColorSaturation = CGFloat(greenColorSlider.value)
        greenColorValue.text = "\((Int)(greenColorSaturation * 255))"
        
        blueColorSaturation = CGFloat(blueColorSlider.value)
        blueColorValue.text = "\((Int)(blueColorSaturation * 255))"
        
        opacity = CGFloat(opacitySlider.value)
        opacityValue.text = String(format: "%1.1f", opacity)
        
        lineWidth = CGFloat(brushSizeSlider.value * 100)
        brushValue.text = String(format: "%1.1f", lineWidth)
        
        viewBrush.drawPreview()
    }
    
}

