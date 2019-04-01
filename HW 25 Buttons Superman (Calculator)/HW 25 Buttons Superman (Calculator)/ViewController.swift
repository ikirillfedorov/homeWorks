//
//  ViewController.swift
//  HW 25 Buttons Superman (Calculator)
//
//  Created by Kirill Fedorov on 31/03/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberFromLabel: Double = 0.0
    var secondNumber: Double = 0.0
    var operationTag = 0
    
    var isLabelEmpty = true
    var isSecondNumberEmpty = true
    var isDecimal = false
    
    var power:Double = 1.0
    
    func showResult() {
        switch String(numberFromLabel) {
        case let textFromLabel where textFromLabel.hasSuffix(".0"):
            resultLabel.text = String(Int(numberFromLabel))
        default:
            resultLabel.text = String(numberFromLabel)
        }
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func inverse(_ sender: UIButton) {
        numberFromLabel = -numberFromLabel
        showResult()
    }
    
    @IBAction func present(_ sender: UIButton) {
        numberFromLabel = numberFromLabel / 100 * secondNumber
        showResult()
    }

    @IBAction func digitalButtons(_ sender: UIButton) {
        if isLabelEmpty {
            numberFromLabel = 0
            isLabelEmpty = false
        }
        if !isDecimal {
            numberFromLabel = numberFromLabel * 10 + Double(sender.tag)
            showResult()
        } else {
            numberFromLabel = numberFromLabel + Double(sender.tag) / pow(10, power)
            power += 1
            showResult()
        }
    }
    
    @IBAction func operationButtons(_ sender: UIButton) {
        if !isLabelEmpty && isSecondNumberEmpty {
            switch operationTag {
            case 11:
                numberFromLabel = secondNumber / numberFromLabel
            case 12:
                numberFromLabel = secondNumber * numberFromLabel
            case 13:
                numberFromLabel = secondNumber - numberFromLabel
            case 14:
                numberFromLabel = secondNumber + numberFromLabel
            default:
                showResult()
            }
        }
        operationTag = sender.tag
        secondNumber = numberFromLabel
        isLabelEmpty = true
        isSecondNumberEmpty = true
        showResult()
        power = 1
        isDecimal = false
    }
    
    @IBAction func decimalButton(_ sender: UIButton) {
        if !isDecimal {
            isDecimal = true
        }
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        numberFromLabel = 0.0
        secondNumber = 0.0
        operationTag = 0
        isLabelEmpty = true
        isSecondNumberEmpty = true
        isDecimal = false
        power = 1.0
        showResult()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

