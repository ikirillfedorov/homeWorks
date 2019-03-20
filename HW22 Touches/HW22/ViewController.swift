//
//  ViewController.swift
//  HW22
//
//  Created by Kirill Fedorov on 17/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//



//1. Создайте шахматное поле (8х8), используйте черные сабвьюхи
//2. Добавьте балые и красные шашки на черные клетки (используйте начальное расположение в шашках)
//3. Реализуйте механизм драг'н'дроп подобно тому, что я сделал в примере, но с условиями:
//4. Шашки должны ставать в центр черных клеток.
//5. Даже если я отпустил шашку над центром белой клетки - она должна переместиться в центр ближайшей к отпусканию черной клетки.
//6. Шашки не могут становиться друг на друга
//7. Шашки не могут быть поставлены за пределы поля.

import UIKit

class ViewController: UIViewController {
    
    var blackCells = [UIView]()
    var chessBoard: UIView!
    var checker = UIView()
    var touchOffSet = CGPoint()
    var checkers = [UIView]()
    
    func cellIsFree(cell: UIView, selectedChecker: UIView, chessBoard: UIView) -> Bool {
        for checker in checkers {
            if selectedChecker == checker {
                continue
            }
            if cell.point(inside: chessBoard.convert(checker.center, to: cell), with: nil) {
                return false
            }
        }
        return true
    }
    
    func findNearesBlackCell(blackCells: [UIView], checker: UIView, chessBoard: UIView) -> UIView {
        var delta = Float.greatestFiniteMagnitude
        var nearestCell: UIView!
        
        for blackCell in blackCells {
            let deltaX = fabsf(Float(blackCell.center.x - checker.center.x))
            let deltaY = fabsf(Float(blackCell.center.y - checker.center.y))
            
            if delta > sqrtf(Float(deltaX * deltaX + deltaY * deltaY)) &&
                cellIsFree(cell: blackCell, selectedChecker: checker, chessBoard: chessBoard) {
                nearestCell = blackCell
                delta = sqrtf(deltaX * deltaX + deltaY * deltaY)
            }
        }
        return nearestCell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .lightGray
        let minSide = min(self.view.frame.width, self.view.frame.height)
        let cellSize = minSide / 8
        let multiplier = 0.7;
        let indentInCell = cellSize * CGFloat((1 - multiplier) / 2);
        let checkerSize = cellSize * CGFloat(multiplier)
        let rangeWithOutCheckers = 3...4
        
        chessBoard = UIView(frame: CGRect(x: self.view.center.x - minSide / 2, y: self.view.center.y - minSide / 2, width: minSide, height: minSide))
        let chessBoardImage = UIImage(named: "chessBoard.jpg")
        if chessBoardImage != nil {
            chessBoard.backgroundColor = UIColor(patternImage: chessBoardImage!)
        }
        self.view.addSubview(chessBoard)
        
        chessBoard.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        
        for i in 0..<8 {
            for j in 0..<8 {
                guard ((i + j) % 2 != 0) else { continue }
                let blackCell = UIView(frame: CGRect(x: cellSize * CGFloat(i),
                                                     y: cellSize * CGFloat(j),
                                                     width: cellSize,
                                                     height: cellSize))
                
                let blackCellImag = UIImage(named: "blackCell.jpg")
                if blackCellImag != nil {
                    blackCell.backgroundColor = UIColor(patternImage: blackCellImag!)
                }
                chessBoard.addSubview(blackCell)
                blackCells.append(blackCell)
                
                if (j < rangeWithOutCheckers.lowerBound || j > rangeWithOutCheckers.upperBound) {
                    let checker = UIView.init(frame: CGRect(x: cellSize * CGFloat(i) + indentInCell,
                                                            y: cellSize * CGFloat(j) + indentInCell,
                                                            width: checkerSize,
                                                            height: checkerSize))
                    
                    checker.backgroundColor = j < rangeWithOutCheckers.lowerBound ? .white : .red
                    checker.layer.cornerRadius = checker.frame.width / 2
                    checker.tag = 1
                    chessBoard.addSubview(checker)
                    checkers.append(checker)
                }
            }
        }
    }
    
    // touches methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.randomElement()
        guard let pointOnChessBoard = touch?.location(in: chessBoard) else {
            return
        }
        let selectedView = chessBoard.hitTest(pointOnChessBoard, with: event)
        
        if selectedView != nil && selectedView?.tag == 1 {
            self.checker = selectedView!
            chessBoard.bringSubviewToFront(self.checker)
            
            if touch != nil {
                let touchPoint = touch!.location(in: self.checker)
                touchOffSet = CGPoint(x: (self.checker.bounds.midX) - (touchPoint.x),
                                      y: (self.checker.bounds.midY) - (touchPoint.y))
                
                UIView.animate(withDuration: 0.3) {
                    self.checker.transform = self.checker.transform.scaledBy(x: 1.3, y: 1.3)
                    self.checker.alpha = 0.7
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        let pointOnChessBoard = touch?.location(in: chessBoard)
        if pointOnChessBoard != nil {
            let newPoint = CGPoint(x: pointOnChessBoard!.x + touchOffSet.x, y: pointOnChessBoard!.y + touchOffSet.y)
            self.checker.center = newPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nearestCell = findNearesBlackCell(blackCells: blackCells, checker: self.checker, chessBoard: chessBoard)
        UIView.animate(withDuration: 0.3) {
            self.checker.center = nearestCell.center
        }
        
        UIView.animate(withDuration: 0.3) {
            self.checker.transform = CGAffineTransform.identity
            self.checker.alpha = 1
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
    }
}


