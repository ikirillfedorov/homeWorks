//
//  DrawingView.swift
//  HW 24 Drawing Superman
//
//  Created by Kirill Fedorov on 25/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

protocol DrawingViewDrawingParametersSource: class {
    
    var lastPoint: CGPoint { get }
    var color: CGColor { get }
    var opacity: CGFloat { get }
    var lineWidth: CGFloat { get }
    
}

class DrawingView: UIImageView {
    
    weak var dataSource: DrawingViewDrawingParametersSource? = nil
    
    // MARK: - Helpful functions
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        guard let dataSource = dataSource else { return }
        let color = dataSource.color
        let imageRect = makeImageRect(frame)
        
        UIGraphicsBeginImageContext(frame.size) // image begins
        defer { UIGraphicsEndImageContext() } // image ends

        guard let context = UIGraphicsGetCurrentContext(),
              let image = image else { return }
        image.draw(in: imageRect)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setLineWidth(dataSource.lineWidth)
        context.setStrokeColor(color)
        context.setBlendMode(.normal)
        context.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        alpha = dataSource.opacity
    }
    
    private func makeImageRect(_ rect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: rect.width, height: rect.height).integral
    }
    
    func merge(tempView: UIImageView, intoMainView mainView: UIImageView) {
        guard let dataSource = dataSource else { return }
        UIGraphicsBeginImageContext(mainView.frame.size) // image begins
        defer { UIGraphicsEndImageContext() } // image ends
        
        let imageRect = makeImageRect(mainView.frame)
        
        mainView.image?.draw(in: imageRect, blendMode: .normal, alpha: 1)
        tempView.image?.draw(in: imageRect, blendMode: .normal, alpha: dataSource.opacity)
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        tempView.image = nil
    }
    
    func drawPreview() {
        guard let dataSource = dataSource else { return }

        image = nil
        
        let color = dataSource.color
        let imageRect = makeImageRect(frame)
        
        UIGraphicsBeginImageContext(frame.size) // image begins
        defer { UIGraphicsEndImageContext() } // image ends
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        image?.draw(in: imageRect)
        
        context.move(to: CGPoint(x: bounds.midX, y: bounds.midY))
        context.addLine(to: CGPoint(x: bounds.midX, y: bounds.midY))
        
        context.setLineCap(.round)
        context.setLineWidth(dataSource.lineWidth)
        context.setStrokeColor(color)
        context.strokePath()
        
        image = UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
