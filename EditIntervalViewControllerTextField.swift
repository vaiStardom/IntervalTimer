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
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textFields.contains(textField) {
            compareFieldsWithSavedInterval()
            configureNavBar()
            print("------> EditIntervalViewController textFieldDidEndEditing(textField:) total seconds = \(totalSeconds())")
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
        
        if ((currentText?.characters.count)! < 1
            && string.characters.count > 0
            && string.containsOnlyCharactersIn(matchCharacter: allowedChars)){ // User inputs 1 number
            
            textField.text = string
            nextResponder?.becomeFirstResponder()
            
            return false
            
        } else if ((currentText?.characters.count)! >= 1
            && string.characters.count == 0){ // User deletes the contents
            
            if (previousResponder == nil){ //if we cant find the revious textField, set it to the first text field
                previousResponder = textField.superview?.viewWithTag(0) as? UITextField
            }
            
            textField.text = zeroWidthSpace
            previousResponder?.becomeFirstResponder()
            return false
            
        } else if ((currentText?.characters.count)! == 0
            && string.characters.count == 0){ // TextField is empty, user backspaces.
            
            textField.text = zeroWidthSpace
            
            if let previousTextField = previousResponder {
                previousTextField.text = zeroWidthSpace
            }
            previousResponder!.becomeFirstResponder()
            
            return false
        } else {
            textField.text = zeroWidthSpace
            return false
        }
    }
}
