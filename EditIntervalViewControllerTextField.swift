//
//  EditIntervalViewControllerTextField.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//MARK: - Text Field Management
extension EditIntervalViewController: UITextFieldDelegate {
    func manageTextFields2(string: String) {
    
        if !string.isEmpty {
            dictTextFieldValues[1] = string
            dictTextFieldValues[2] = secondTextField1.text
            dictTextFieldValues[3] = secondTextField2.text
            dictTextFieldValues[4] = minuteTextField1.text
            dictTextFieldValues[5] = minuteTextField2.text
            dictTextFieldValues[6] = hourTextField1.text
            
            secondTextField1.text = dictTextFieldValues[1]
            secondTextField2.text = dictTextFieldValues[2]
            minuteTextField1.text = dictTextFieldValues[3]
            minuteTextField2.text = dictTextFieldValues[4]
            hourTextField1.text = dictTextFieldValues[5]
            hourTextField2.text = dictTextFieldValues[6]
            
            isEditingAnInterval = true
            configureNavBar()
        } else {
            dictTextFieldValues[1] = secondTextField2.text
            dictTextFieldValues[2] = minuteTextField1.text
            dictTextFieldValues[3] = minuteTextField2.text
            dictTextFieldValues[4] = hourTextField1.text
            dictTextFieldValues[5] = hourTextField2.text
            dictTextFieldValues[6] = string
        
            secondTextField1.text = dictTextFieldValues[1]
            secondTextField2.text = dictTextFieldValues[2]
            minuteTextField1.text = dictTextFieldValues[3]
            minuteTextField2.text = dictTextFieldValues[4]
            hourTextField1.text = dictTextFieldValues[5]
            hourTextField2.text = dictTextFieldValues[6]
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //trim out the invisible sign
        let trimmedOutSign = textField.text?.replacingOccurrences(of: zeroWidthSpace, with: "")
        let currentText = trimmedOutSign
        
        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) as? UITextField
        
        let previousTag = (textField.tag - 1 == 0 ? 1 : textField.tag - 1)
        var previousResponder = textField.superview?.viewWithTag(previousTag) as? UITextField
        
        print("------> EditIntervalViewController textField.text = \(textField.text), replacementString = \(string)")
        
        if textField.tag == 1 {
            if !string.isEmpty{
                if let theCurrentText = currentText, theCurrentText.isEmpty {
                    isEditingAnInterval = true
                    configureNavBar()
                    return true
                } else {
                    manageTextFields2(string: string)
                    compareFieldsWithPassedInterval()
                    return false
                }
            } else { //user wants to delete (backtrack)
                manageTextFields2(string: string)
                return false
            }
        } else {
            if ((currentText?.characters.count)! < 1
                && string.characters.count > 0
                && string.containsOnlyCharactersIn(matchCharacter: allowedChars)){ // User inputs 1 number
                
                textField.text = string
                nextResponder?.becomeFirstResponder()
                compareFieldsWithPassedInterval()
                return false
                
            } else if ((currentText?.characters.count)! >= 1
                && string.characters.count == 0){ // User deletes the contents
                
                if (previousResponder == nil){ //if we cant find the revious textField, set it to the first text field
                    previousResponder = textField.superview?.viewWithTag(0) as? UITextField
                }
                
                textField.text = zeroWidthSpace
                previousResponder?.becomeFirstResponder()
                compareFieldsWithPassedInterval()
                return false
                
            } else if ((currentText?.characters.count)! == 0
                && string.characters.count == 0){ // TextField is empty, user backspaces.
                
                textField.text = zeroWidthSpace
                
                if let previousTextField = previousResponder {
                    previousTextField.text = zeroWidthSpace
                }
                previousResponder!.becomeFirstResponder()
                compareFieldsWithPassedInterval()
                return false
            } else {
                textField.text = zeroWidthSpace
                compareFieldsWithPassedInterval()
                return false
            }
        }
    }
}
