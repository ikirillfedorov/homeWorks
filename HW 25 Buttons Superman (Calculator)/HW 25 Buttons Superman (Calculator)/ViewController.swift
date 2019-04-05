//
//  ViewController.swift
//  HW 25 Buttons Superman (Calculator)
//
//  Created by Kirill Fedorov on 31/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum OperationTag: Int {
        case divide = 11, multiply, minus, plus, equal, none
    }
    
    var resultNumber = 0.0
    var operandNumber = 0.0
    var operationTag = OperationTag.none
    
    var isLabelEmpty: Bool {
        return resultLabel.text?.isEmpty ?? true
    }
//    var isDecimal = false

    var isDecimal: Bool {
        return operationTag != .none || resultLabel.text?.contains(".") ?? false
    }

    
    var digits = 1.0
    
    @IBOutlet weak var resultLabel: UILabel!
    
    func showResult() {
        if String(resultNumber).hasSuffix(".0") {
            resultLabel.text = String(Int(resultNumber))
        } else {
            resultLabel.text = String(resultNumber)
        }
    }
    
    @IBAction func inverse(_ sender: UIButton) {
        resultNumber = -resultNumber
        showResult()
    }
    
    @IBAction func didPressPercentageButton(_ sender: UIButton) {
        resultNumber = resultNumber / 100 * operandNumber
        showResult()
    }
    
    @IBAction func didPressNumberButton(_ sender: UIButton) {
        if isLabelEmpty {
            resultNumber = 0
        }
        if !isDecimal {
            resultNumber = resultNumber * 10 + Double(sender.tag)
            showResult()
        } else {
            resultNumber = resultNumber + Double(sender.tag) / pow(10, digits)
            digits += 1
            showResult()
        }
    }
    
    @IBAction func didPressOperationButton(_ sender: UIButton) {
        if !isLabelEmpty {
            switch operationTag {
            case .divide:
                resultNumber = operandNumber / resultNumber
            case .multiply:
                resultNumber = operandNumber * resultNumber
            case .minus:
                resultNumber = operandNumber - resultNumber
            case .plus:
                resultNumber = operandNumber + resultNumber
            default:
                break
            }
        }
        operationTag = OperationTag(rawValue: sender.tag) ?? .none
        operandNumber = resultNumber
        showResult()
        digits = 1
//        isDecimal = false
    }
    
    @IBAction func didPressDotButton(_ sender: UIButton) {
        if !isDecimal {
            resultLabel.text?.append(".")
        }
    }
    
    @IBAction func didPressClearButton(_ sender: UIButton) {
        resultNumber = 0.0
        operandNumber = 0.0
        operationTag = .none
//        isDecimal = false
        digits = 1.0
        showResult()
    }
}

