//
//  ViewController.swift
//  HW 27-28 TextField
//
//  Created by Kirill Fedorov on 13/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var emailCharactersLimit = 30
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    @IBOutlet weak var emailCharactersLimitLabel: UILabel!
    @IBOutlet var textLabelsCollection: [UILabel]!
    
    @IBAction func actionTextChanged(_ sender: UITextField) {
        if let currentTextFieldIndex = textFieldsCollection.firstIndex(of: sender) {
            textLabelsCollection[currentTextFieldIndex].text = sender.text
        }
    }
    
    enum TextFieldType: Int {
        case firstName = 0, lastName, login, password, age, phoneNumber, email
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
                textFieldsCollection.last?.resignFirstResponder()
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
        var validationSet = CharacterSet.init(charactersIn: "!#$%&'*+-/=?^`{|}~[]; ")
        emailCharactersLimitLabel.text = "characters limit: \(emailTextLenght)/\(emailCharactersLimit)"
        
        if let text = textField.text {
            if text.contains("@") {
                validationSet.insert(charactersIn: "@")
            }
        }
        
        let components = string.components(separatedBy: validationSet)

        guard components.count <= 1 else { return false }
        guard emailTextLenght < emailCharactersLimit || string == "" else { return false }

        return true
    }

    //phone number
    func phoneTextFieldChanged(_ string: String, _ textField: UITextField, _ range: NSRange) -> Bool {
        let validationSet = CharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: validationSet)
        
        if components.count > 1 {
            return false
        }
        
        var newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
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
            resultString = String(newString.suffix(localNumberLength))
            if resultString.count > 3 {
                let index = newString.index(newString.startIndex, offsetBy: 3)
                resultString.insert("-", at: index)
            }
        }
        
        if newString.count > localNumberMaxLength {
            let areaCodeLength = min(newString.count - localNumberMaxLength, areaCodeMaxLength);
            let offset = newString.count - localNumberMaxLength > areaCodeMaxLength ? countryCodeMaxLength : 0
            let indexEnd = newString.index(newString.startIndex, offsetBy: areaCodeLength + offset)
            let indexStart = newString.index(newString.startIndex, offsetBy: offset)

            var area = newString[indexStart..<indexEnd]
            area = " (\(area)) "
            resultString.insert(contentsOf: area, at: newString.startIndex)
        }
        
        if newString.count > localNumberMaxLength + areaCodeMaxLength {
            let countryCodeLength = min(newString.count - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength)
            let index = newString.index(newString.startIndex, offsetBy: countryCodeLength)
            var country = newString[..<index]
            country = "+\(country) "
            
            resultString.insert(contentsOf: country, at: newString.startIndex)
        }
        
        textField.text = resultString;
        textLabelsCollection[TextFieldType.phoneNumber.rawValue].text = resultString
        
        return false;
    }
    
// MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
        case TextFieldType.phoneNumber.rawValue:
            return phoneTextFieldChanged(string, textField, range)
        case TextFieldType.email.rawValue:
            return emailTextFieldChanged(string, textField, range)
        default:
            return true
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.isEqual(textFieldsCollection[TextFieldType.email.rawValue]) {
            emailCharactersLimitLabel.text = "characters limit: 0/30"
        }
        return true
    }
}


