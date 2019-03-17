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

var chessBoard: UIView!
var checker = UIView()
var touchOffSet = CGPoint()
var checkers = [UIView]()

func cellIsFree(cell: UIView, selectedChecker: UIView, chessBoard: UIView) -> Bool {
    var returnedValue = true
    for checker in checkers {
        if selectedChecker == checker {
            continue
        }
        if cell.point(inside: chessBoard.convert(checker.center, to: cell), with: nil) {
            returnedValue = false
        }
    }
    return returnedValue
}

func findNearesBlackCell(blackCells: [UIView], checker: UIView, chessBoard: UIView) -> UIView {
    var delta = Float.greatestFiniteMagnitude
    var nearestCell = UIView()
    
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


class ViewController: UIViewController {
    
    var blackCells = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .lightGray
        let minSide = min(self.view.frame.width, self.view.frame.height)
        let cellSize = minSide / 8
        let multiplier = 0.7;
        let indentInCell = cellSize * CGFloat((1 - multiplier) / 2);
        let checkerSize = cellSize * CGFloat(multiplier)
        
        chessBoard = UIView(frame: CGRect(x: self.view.center.x - minSide / 2, y: self.view.center.y - minSide / 2, width: minSide, height: minSide))
        let chessBoardImage = UIImage(named: "chessBoard.jpg")
        if chessBoardImage != nil {
            chessBoard.backgroundColor = UIColor(patternImage: chessBoardImage!)
        }
        self.view.addSubview(chessBoard)
        
        chessBoard.autoresizingMask = [.flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        
        for i in 0..<8 {
            for j in 0..<8 {
                if ((i + j) % 2 != 0) {
                    
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
                    
                    if (j < 3 || j > 4) {
                        let checker = UIView.init(frame: CGRect(x: cellSize * CGFloat(i) + indentInCell,
                                                                y: cellSize * CGFloat(j) + indentInCell,
                                                                width: checkerSize,
                                                                height: checkerSize))
                        
                        checker.backgroundColor = j < 3 ? .white : .red
                        checker.layer.cornerRadius = checker.frame.width / 2
                        checker.tag = 1
                        chessBoard.addSubview(checker)
                        checkers.append(checker)
                    }
                }
            }
        }
    }
    
    // touches methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.randomElement()
        let pointOnChessBoard = touch?.location(in: chessBoard)
        let selectedView = chessBoard.hitTest(pointOnChessBoard!, with: event)
        
        if selectedView != nil && selectedView?.tag == 1 {
            checker = selectedView!
            chessBoard.bringSubviewToFront(checker)
            
            let touchPoint = touch!.location(in: checker)
            touchOffSet = CGPoint(x: (checker.bounds.midX) - (touchPoint.x),
                                  y: (checker.bounds.midY) - (touchPoint.y))
            
            UIView.animate(withDuration: 0.3) {
                checker.transform = checker.transform.scaledBy(x: 1.3, y: 1.3)
                checker.alpha = 0.7
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        let pointOnChessBoard = touch?.location(in: chessBoard)
        
        let newPoint = CGPoint(x: (pointOnChessBoard?.x)! + touchOffSet.x, y: (pointOnChessBoard?.y)! + touchOffSet.y)
        checker.center = newPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nearestCell = findNearesBlackCell(blackCells: blackCells, checker: checker, chessBoard: chessBoard)
        checker.center = nearestCell.center
        
        UIView.animate(withDuration: 0.3) {
            checker.transform = CGAffineTransform.identity
            checker.alpha = 1
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.count)
    }
}


