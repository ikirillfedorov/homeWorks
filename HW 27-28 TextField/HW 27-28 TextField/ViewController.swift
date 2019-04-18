//
//  ViewController.swift
//  HW 27-28 TextField
//
//  Created by Kirill Fedorov on 13/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController {
    
    enum TextFieldType: Int {
        case firstName = 0
        case lastName = 1
        case login = 2
        case password = 3
        case age = 4
        case phoneNumber = 5
        case email = 6
    }
    
    var emailCharactersLimit = 30
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    @IBOutlet weak var emailCharactersLimitLabel: UILabel!
    @IBOutlet var textLabelsCollection: [UILabel]!
    
    @IBAction func didChange(_ sender: UITextField) {
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
            if textField.isEqual(textFieldsCollection.last) {
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
        var validationSet = CharacterSet.letters
        validationSet.insert(charactersIn: "_-@.1234567890")
        
        emailCharactersLimitLabel.text = "characters limit: \(emailTextLenght)/\(emailCharactersLimit)"
        
        if let text = textField.text {
            if text.contains("@") {
                validationSet.remove(charactersIn: "@")
            }
        }
        
        let components = string.components(separatedBy: validationSet.inverted)
        
        return components.count <= 1 &&
            emailTextLenght < emailCharactersLimit ||
            string.isEmpty
    }
    
    //phone number
    fileprivate func makeLocalNumber(_ resultString: inout String, _ newString: String, _ localNumberLength: Int) {
        resultString = String(newString.suffix(localNumberLength))
        if resultString.count > 3 {
            let index = newString.index(newString.startIndex, offsetBy: 3)
            resultString.insert("-", at: index)
        }
    }
    
    fileprivate func makeAreaNumber(_ newString: String, _ localNumberMaxLength: Int, _ areaCodeMaxLength: Int, _ countryCodeMaxLength: Int, _ resultString: inout String) {
        let areaCodeLength = min(newString.count - localNumberMaxLength, areaCodeMaxLength);
        let offset = newString.count - localNumberMaxLength > areaCodeMaxLength ? countryCodeMaxLength : 0
        let indexEnd = newString.index(newString.startIndex, offsetBy: areaCodeLength + offset)
        let indexStart = newString.index(newString.startIndex, offsetBy: offset)
        
        var area = newString[indexStart..<indexEnd]
        area = " (\(area)) "
        resultString.insert(contentsOf: area, at: newString.startIndex)
    }
    
    fileprivate func makeCountryNumber(_ newString: String, _ localNumberMaxLength: Int, _ areaCodeMaxLength: Int, _ countryCodeMaxLength: Int, _ resultString: inout String) {
        let countryCodeLength = min(newString.count - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength)
        let index = newString.index(newString.startIndex, offsetBy: countryCodeLength)
        var country = newString[..<index]
        country = "+\(country) "
        
        resultString.insert(contentsOf: country, at: newString.startIndex)
    }
    
    func phoneTextFieldChanged(_ string: String, _ textField: UITextField, _ range: NSRange) -> Bool {
        let validationSet = CharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: validationSet)
        
        guard components.count <= 1 else { return false }
        
        guard let text = textField.text as NSString? else { return false }
        var newString = text.replacingCharacters(in: range, with: string)
        
        let validComponents = newString.components(separatedBy: validationSet)
        newString = validComponents.joined(separator: "");
        
        let localNumberMaxLength = 7;
        let areaCodeMaxLength = 3;
        let countryCodeMaxLength = 1;
        
        if newString.count > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength {
            return false;
        }
        
        var resultString = ""
        
        let localNumberLength = min(newString.count, localNumberMaxLength)
        
        if localNumberLength > 0 {
            makeLocalNumber(&resultString, newString, localNumberLength)
        }
        
        if newString.count > localNumberMaxLength {
            makeAreaNumber(newString, localNumberMaxLength, areaCodeMaxLength, countryCodeMaxLength, &resultString)
        }
        
        if newString.count > localNumberMaxLength + areaCodeMaxLength {
            makeCountryNumber(newString, localNumberMaxLength, areaCodeMaxLength, countryCodeMaxLength, &resultString)
        }
        
        textField.text = resultString;
        guard textFieldsCollection.count > TextFieldType.email.rawValue else { return false }
        textLabelsCollection[TextFieldType.phoneNumber.rawValue].text = resultString
        
        return false;
    }
}


