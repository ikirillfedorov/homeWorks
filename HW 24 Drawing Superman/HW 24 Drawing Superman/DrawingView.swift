//
//  DrawingView.swift
//  HW 24 Drawing Superman
//
//  Created by Kirill Fedorov on 25/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol DrawingViewColorSource {
    
    var lastPoint:  CGPoint  { get set }
    var redColorSaturation:   CGFloat  { get set }
    var greenColorSaturation: CGFloat  { get set }
    var blueColorSaturation:  CGFloat  { get set }
    var opacity:    CGFloat  { get set }
    var lineWidth:  CGFloat  { get set }
}

class DrawingView: UIImageView {
    
    var delegate: DrawingViewColorSource! = nil
    
    // MARK: - Draw rect
    override func draw(_ rect: CGRect) {

        // Drawing code
    }
    // MARK: - Helpful functions
    
    func makeColor() -> CGColor {
        return UIColor(red: delegate.redColorSaturation, green: delegate.greenColorSaturation, blue: delegate.blueColorSaturation, alpha: 1).cgColor
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        let color = makeColor()
        let imageRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height).integral
        
        UIGraphicsBeginImageContext(frame.size) // image begins
        defer { UIGraphicsEndImageContext() } // image ends

        guard let context = UIGraphicsGetCurrentContext() else { return }
        image?.draw(in: imageRect)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setLineWidth(delegate.lineWidth)
        context.setStrokeColor(color)
        context.setBlendMode(.normal)
        context.strokePath()
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        alpha = delegate.opacity
    }
    
    func merge(tempView: UIImageView, intoMainView mainView: UIImageView) {
        
        UIGraphicsBeginImageContext(mainView.frame.size) // image begins
        defer { UIGraphicsEndImageContext() } // image ends
        
        let imageRect = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height).integral
        
        mainView.image?.draw(in: imageRect, blendMode: .normal, alpha: 1)
        tempView.image?.draw(in: imageRect, blendMode: .normal, alpha: delegate.opacity)
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        tempView.image = nil
    }
    
    func drawPreview() {
        
        image = nil
        
        let color = makeColor()
        let imageRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height).integral
        
        UIGraphicsBeginImageContext(frame.size) // image begins
        defer { UIGraphicsEndImageContext() } // image ends
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        image?.draw(in: imageRect)
        
        context.move(to: CGPoint(x: bounds.midX, y: bounds.midY))
        context.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY))
        
        context.setLineCap(.round)
        context.setLineWidth(delegate.lineWidth)
        context.setStrokeColor(color)
        context.strokePath()
        
        image = UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
