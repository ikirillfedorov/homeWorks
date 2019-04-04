//
//  DrawingView.swift
//  HW 24 Drawing
//
//  Created by Kirill Fedorov on 24/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    var starRects = [CGRect]()
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        createStarInsideMainRect(mainRect: rect, count: 30)
    }
    
    
    //        Ученик.
    //        1. Нарисуйте пятиконечную звезду :)
    //        2. Добавьте окружности на концах звезды
    //        3. Соедините окружности линиями
    //    Студент.
    //        4. Закрасте звезду любым цветом цветом оО
    //        5. При каждой перерисовке рисуйте пять таких звезд (только мелких) в рандомных точках экрана
    
    func randomCGColor() -> CGColor {
        return UIColor(red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       alpha: 1.0).cgColor
    }
    
    func isFreePlace(forNewRect newRect: CGRect, inRects rects: [CGRect]) -> Bool {
        return rects.first { $0.intersects(newRect) } == nil
    }
    
    func createRandomRect(insideMainRect rect: CGRect) -> CGRect? {
        let minSide = min(rect.maxX, rect.maxY) //414
        let rectSize = minSide / 8 //51.75
        
        let pointX = CGFloat(Int.random(in: 0...Int(rect.maxX) - Int(rectSize)))
        let pointY = CGFloat(Int.random(in: 0...Int(rect.maxY) - Int(rectSize)))
        
        let rectOfStar = CGRect(x: pointX, y: pointY, width: rectSize, height: rectSize)
        
        var result: CGRect?
        
        if isFreePlace(forNewRect: rectOfStar, inRects: starRects) {
            starRects.append(rectOfStar)
            result = rectOfStar
        }
        return result
    }
    
    func drawStars(context: CGContext,
                   centerX: CGFloat,
                   centerY: CGFloat,
                   radiusStar: CGFloat,
                   vertexStarPoint: inout CGPoint,
                   angle: Double) {
        
        context.move(to: CGPoint(x: centerX, y: centerY - radiusStar))
        
        context.setLineWidth(2.5)
        context.setStrokeColor(randomCGColor())
        context.setFillColor(randomCGColor())

        for tempI in 1..<6 {
            let i = (Double)(tempI)
            vertexStarPoint.x = radiusStar * (CGFloat)(sin(i * angle))
            vertexStarPoint.y = radiusStar * (CGFloat)(cos(i * angle))
            
            context.addLine(to: CGPoint(x: centerX + vertexStarPoint.x, y: centerY - vertexStarPoint.y))
        }
        context.fillPath()
    }
    
    func drawLinesAndCirles(context: CGContext,
                            centerX: CGFloat,
                            centerY: CGFloat,
                            radiusStar: CGFloat,
                            vertexStarPoint: inout CGPoint,
                            angle: Double) {
        
        context.setFillColor(UIColor.blue.cgColor)
        context.move(to: CGPoint(x: centerX, y: centerY - radiusStar))
        
        for i in 1..<6 {
            vertexStarPoint.x = radiusStar * (CGFloat)(sin((Double)(i) * angle / 2))
            vertexStarPoint.y = radiusStar * (CGFloat)(cos((Double)(i) * angle / 2))
            
            let point = CGPoint(x: centerX + vertexStarPoint.x, y: centerY - vertexStarPoint.y)
            context.addLine(to: point)
            context.setLineCap(.round)
            context.strokePath()
            
            let sizeRect = radiusStar / 5
            
            context.addEllipse(in: CGRect(x: point.x - sizeRect / 2,
                                          y: point.y - sizeRect / 2,
                                          width: sizeRect, height: sizeRect))
            context.fillPath()
            context.move(to: point)
        }
    }
    
    func createStarInsideMainRect(mainRect: CGRect, count: Int) {
        while starRects.count < count {
            if let rectOfStar = createRandomRect(insideMainRect: mainRect) {
                
                let radiusStar = rectOfStar.width / 2
                let centerX = rectOfStar.midX
                let centerY = rectOfStar.midY
                
                guard let context = UIGraphicsGetCurrentContext() else { return }
                
                var vertexStarPoint = CGPoint()
                let angle = (4.0 * Double.pi) / 5.0
                
                
                // draw a stars
                drawStars(context: context, centerX: centerX, centerY: centerY, radiusStar: radiusStar, vertexStarPoint: &vertexStarPoint, angle: angle)
                // draw lines and circles
                drawLinesAndCirles(context: context, centerX: centerX, centerY: centerY, radiusStar: radiusStar, vertexStarPoint: &vertexStarPoint, angle: angle)
            }
        }
        starRects.removeAll()
    }
}
