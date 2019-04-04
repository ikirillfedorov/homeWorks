//
//  ViewController.swift
//  HW 25 Buttons Superman (Calculator)
//
//  Created by Kirill Fedorov on 31/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum operationTags: Int {
        case divide = 11, multiply, minus, plus, equal
    }
    
    var numberFromLabel: Double = 0.0
    var secondNumber: Double = 0.0
    var operationTag = 0
    
    var isLabelEmpty = true
    var isDecimal = false
    
    var digits = 1.0
    
    @IBOutlet weak var resultLabel: UILabel!
    
    func showResult() {
        if String(numberFromLabel).hasSuffix(".0") {
            resultLabel.text = String(Int(numberFromLabel))
        } else {
            resultLabel.text = String(numberFromLabel)
        }
    }
    
    @IBAction func inverse(_ sender: UIButton) {
        numberFromLabel = -numberFromLabel
        showResult()
    }
    
    @IBAction func didPressPercentageButton(_ sender: UIButton) {
        numberFromLabel = numberFromLabel / 100 * secondNumber
        showResult()
    }
    
    @IBAction func didPressNumberButton(_ sender: UIButton) {
        if isLabelEmpty {
            numberFromLabel = 0
            isLabelEmpty = false
        }
        if !isDecimal {
            numberFromLabel = numberFromLabel * 10 + Double(sender.tag)
            showResult()
        } else {
            numberFromLabel = numberFromLabel + Double(sender.tag) / pow(10, digits)
            digits += 1
            showResult()
        }
    }
    
    @IBAction func didPressOperationButton(_ sender: UIButton) {
        if !isLabelEmpty {
            switch operationTag {
            case operationTags.divide.rawValue:
                numberFromLabel = secondNumber / numberFromLabel
            case operationTags.multiply.rawValue:
                numberFromLabel = secondNumber * numberFromLabel
            case operationTags.minus.rawValue:
                numberFromLabel = secondNumber - numberFromLabel
            case operationTags.plus.rawValue:
                numberFromLabel = secondNumber + numberFromLabel
            case operationTags.equal.rawValue:
                showResult()
            default:
                break
            }
        }
        operationTag = sender.tag
        secondNumber = numberFromLabel
        isLabelEmpty = true
        showResult()
        digits = 1
        isDecimal = false
    }
    
    @IBAction func didPressDotButton(_ sender: UIButton) {
        isDecimal = true
    }
    
    @IBAction func didPressClearButton(_ sender: UIButton) {
        numberFromLabel = 0.0
        secondNumber = 0.0
        operationTag = 0
        isLabelEmpty = true
        isDecimal = false
        digits = 1.0
        showResult()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

