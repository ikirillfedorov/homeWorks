//
//  AccountViewController.swift
//  HW 29 UITableView
//
//  Created by Kirill Fedorov on 22/04/2019.
//  Copyright © 2019 Kirill Fedorov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //MARK: UserDefaults keys
    let keyNameTextField = "name"
    let keyLastNameTextField = "lastName"
    let keyLoginTextField = "login"
    let keyPasswordtextField = "password"
    let keyphoneNumbertextField = "phoneNuber"
    let keyEmailTextField = "email"
    let keyAgeSlider = "age"
    let keySexSwitch = "sex"
    let keyPayInfo = "pay"
    let keyAgeLabel = "ageLabel"
    let keyPayInfoLabel = "payLabel"
    let keySexLabel = "sexLabel"

    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var phoneNumbertextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var sexSwitch: UISwitch!
    @IBOutlet weak var payInfoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var payInfoLabel: UILabel!
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    @IBAction func actionTextChanged(_ sender: UITextField) {
        save()
    }
    
    @IBAction func actionValueChanged(_ sender: UIControl) {
        
        switch sender.tag {
        case SelectedSender.ageSlider.rawValue:
            ageLabel.text = "Age:\(Int(ageSlider.value))"
        case SelectedSender.sexSwitch.rawValue:
            if sexSwitch.isOn {
                sexLabel.text = "Famale"
            } else {
                sexLabel.text = "Male"
            }
        case SelectedSender.payInfoSender.rawValue:
            let SegmentedControlSender = sender as! UISegmentedControl
            switch SegmentedControlSender.selectedSegmentIndex {
            case 0: payInfoLabel.text = "You pay with: Card"
            case 1: payInfoLabel.text = "You pay with: Cash"
            case 2: payInfoLabel.text = "You pay with: Check"
                break
            default:
                break
            }
        default:
            break
        }
        
        save()
    }
    
    //MARK: save and load
    func save() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.nameTextField.text, forKey: keyNameTextField)
        userDefaults.set(self.lastNameTextField.text, forKey: keyLastNameTextField)
        userDefaults.set(self.loginTextField.text, forKey: keyLoginTextField)
        userDefaults.set(self.passwordtextField.text, forKey: keyPasswordtextField)
        userDefaults.set(self.phoneNumbertextField.text, forKey: keyphoneNumbertextField)
        userDefaults.set(self.emailTextField.text, forKey: keyEmailTextField)
        userDefaults.set(self.ageSlider.value, forKey: keyAgeSlider)
        userDefaults.set(self.sexSwitch.isOn, forKey: keySexSwitch)
        userDefaults.set(self.payInfoSegmentedControl.selectedSegmentIndex, forKey: keyPayInfo)
        userDefaults.set(self.ageLabel.text, forKey: keyAgeLabel)
        userDefaults.set(self.payInfoLabel.text, forKey: keyPayInfoLabel)
        userDefaults.set(self.sexLabel.text, forKey: keySexLabel)
    }
    
    func load() {
        let userDefaults = UserDefaults.standard
        self.nameTextField.text = userDefaults.string(forKey: keyNameTextField) ?? ""
        self.lastNameTextField.text = userDefaults.string(forKey: keyLastNameTextField) ?? ""
        self.loginTextField.text = userDefaults.string(forKey: keyLoginTextField) ?? ""
        self.passwordtextField.text = userDefaults.string(forKey: keyPasswordtextField) ?? ""
        self.phoneNumbertextField.text = userDefaults.string(forKey: keyphoneNumbertextField) ?? ""
        self.emailTextField.text = userDefaults.string(forKey: keyEmailTextField) ?? ""
        self.ageSlider.value = userDefaults.float(forKey: keyAgeSlider)
        self.sexSwitch.isOn = userDefaults.bool(forKey: keySexSwitch)
        self.payInfoSegmentedControl.selectedSegmentIndex = userDefaults.integer(forKey: keyPayInfo)
        self.ageLabel.text = userDefaults.string(forKey: keyAgeLabel) ?? "Age:25"
        self.payInfoLabel.text = userDefaults.string(forKey: keyPayInfoLabel) ?? "You pay with: Cash"
        self.sexLabel.text = userDefaults.string(forKey: keySexLabel) ?? "Male"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        
        for textField in textFieldsCollection {
            textField.delegate = self
        }
    }
    
    //return key
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
        var validationSet = CharacterSet.letters.union(CharacterSet.decimalDigits)
        
        validationSet.insert(charactersIn: "_-@.")
        
        if let text = textField.text {
            if text.contains("@") {
                validationSet.remove(charactersIn: "@")
            }
        }
        
        let components = string.components(separatedBy: validationSet.inverted)
        print(components.count)
        return components.count <= 1
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
        
        return false;
    }
} // end of class TableViewController

extension TableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailTextField:
            return emailTextFieldChanged(string, textField, range)
        case phoneNumbertextField:
            return phoneTextFieldChanged(string, textField, range)
        default:
            return true
        }
    }
}

private extension TableViewController {
    enum Constants {
        static let emailCharactersLimit = 30
        static let localNumberMaxLength = 7;
        static let areaCodeMaxLength = 3;
        static let countryCodeMaxLength = 1;
    }
    
    enum SelectedSender: Int {
        case ageSlider
        case sexSwitch
        case payInfoSender
    }
}

