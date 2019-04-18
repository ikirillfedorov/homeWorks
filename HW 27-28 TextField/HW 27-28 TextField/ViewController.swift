//
//  ViewController.swift
//  HW 27-28 TextField
//
//  Created by Kirill Fedorov on 13/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum TextFieldType: Int {
        case firstName
        case lastName
        case login
        case password
        case age
        case phoneNumber
        case email
    }
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    @IBOutlet weak var emailCharactersLimitLabel: UILabel!
    @IBOutlet var textLabelsCollection: [UILabel]!
    
    @IBAction func didChangeText(_ sender: UITextField) {
        if let currentTextFieldIndex = textFieldsCollection.firstIndex(of: sender) {
            textLabelsCollection[currentTextFieldIndex].text = sender.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for textField in textFieldsCollection {
            textField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let currentTextFieldIndex = textFieldsCollection.firstIndex(of: textField) {
            if textField === textFieldsCollection.last {
                textField.resignFirstResponder()
            } else {
                textFieldsCollection[currentTextFieldIndex + 1].becomeFirstResponder()
            }
        }
        return true
    }
    
    //email adress
    func emailTextFieldChanged(_ string: String, _ textField: UITextField, _ range: NSRange) -> Bool {
        
        guard let textFromEmaiTextField = textField.text else { return true }
        let emailTextLenght = textFromEmaiTextField.count + string.count - range.length
        var validationSet = CharacterSet.letters.union(CharacterSet.decimalDigits)
        
        validationSet.insert(charactersIn: "_-@.")
        
        emailCharactersLimitLabel.text = "characters limit: \(emailTextLenght)/\(Constants.emailCharactersLimit)"
        
        if let text = textField.text {
            if text.contains("@") {
                validationSet.remove(charactersIn: "@")
            }
        }
        
        let components = string.components(separatedBy: validationSet.inverted)
        
        return components.count <= 1 &&
            emailTextLenght < Constants.emailCharactersLimit ||
            string.isEmpty
    }
    
    //phone number
    fileprivate func configureLocalNumber(_ resultString: inout String, _ newString: String, _ localNumberLength: Int) {
        resultString = String(newString.suffix(localNumberLength))
        if resultString.count > Constants.areaCodeMaxLength {
            let index = newString.index(newString.startIndex, offsetBy: Constants.areaCodeMaxLength)
            resultString.insert("-", at: index)
        }
    }
    
    fileprivate func configureAreaNumber(_ newString: String, _ resultString: inout String) {
        let areaCodeLength = min(newString.count - Constants.localNumberMaxLength, Constants.areaCodeMaxLength);
        let offset = newString.count - Constants.localNumberMaxLength > Constants.areaCodeMaxLength ? Constants.countryCodeMaxLength : 0
        let indexEnd = newString.index(newString.startIndex, offsetBy: areaCodeLength + offset)
        let indexStart = newString.index(newString.startIndex, offsetBy: offset)
        
        var area = newString[indexStart..<indexEnd]
        area = " (\(area)) "
        resultString.insert(contentsOf: area, at: newString.startIndex)
    }
    
    fileprivate func configureCountryNumber(_ newString: String, _ resultString: inout String) {
        let countryCodeLength = min(newString.count - Constants.localNumberMaxLength - Constants.areaCodeMaxLength, Constants.countryCodeMaxLength)
        let index = newString.index(newString.startIndex, offsetBy: countryCodeLength)
        var country = newString[..<index]
        country = "+\(country) "
        
        resultString.insert(contentsOf: country, at: newString.startIndex)
    }
    
    func phoneTextFieldChanged(_ string: String, _ textField: UITextField, _ range: NSRange) -> Bool {
        let validationSet = CharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: validationSet)
        
        guard let text = textField.text as NSString?, components.count <= 1 else { return false }
        var newString = text.replacingCharacters(in: range, with: string)
        
        let validComponents = newString.components(separatedBy: validationSet)
        newString = validComponents.joined(separator: "");
        
        
        if newString.count > Constants.localNumberMaxLength + Constants.areaCodeMaxLength + Constants.countryCodeMaxLength {
            return false;
        }
        
        var resultString = ""
        
        let localNumberLength = min(newString.count, Constants.localNumberMaxLength)
        
        if localNumberLength > 0 {
            configureLocalNumber(&resultString, newString, localNumberLength)
        }
        
        if newString.count > Constants.localNumberMaxLength {
            configureAreaNumber(newString, &resultString)
        }
        
        if newString.count > Constants.localNumberMaxLength + Constants.areaCodeMaxLength {
            configureCountryNumber(newString, &resultString)
        }
        
        textField.text = resultString;
        guard textFieldsCollection.count > TextFieldType.email.rawValue else { return false }
        textLabelsCollection[TextFieldType.phoneNumber.rawValue].text = resultString
        
        return false;
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textFiedlType = TextFieldType(rawValue: textField.tag) else { return true }
        switch textFiedlType {
        case .phoneNumber:
            return phoneTextFieldChanged(string, textField, range)
        case .email:
            return emailTextFieldChanged(string, textField, range)
        default:
            return true
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField === textFieldsCollection[TextFieldType.email.rawValue] {
            emailCharactersLimitLabel.text = "characters limit: 0/30"
        }
        return true
    }
}

private extension ViewController {
    enum Constants {
        static let emailCharactersLimit = 30
        static let localNumberMaxLength = 7;
        static let areaCodeMaxLength = 3;
        static let countryCodeMaxLength = 1;
    }
}



