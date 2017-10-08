//
//  EditTimerViewControllerTextField.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-10.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - TextField and TextView Management
extension EditTimerViewController_old : UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didUserModifyATimer()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            if let thePreviousText = textField.text, thePreviousText.characters.count == 1 { //user has emptied the textfield
                isEditing = false
                configureNavBar()
                aesthetics_timerNamePlaceHolder()
                return true
            } else {
                didUserModifyATimer()
                return true
            }
        } else {
            if let thePreviousText = textField.text, thePreviousText.characters.count == 0 {
                isEditing = true
                configureNavBar()
                return true
            } else if string.trimmingCharacters(in: .whitespacesAndNewlines).characters.count > 0 {
                isEditing = true
                configureNavBar()
                return true
            } else {
                didUserModifyATimer()
                return true
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        timerNameTextField.resignFirstResponder()
        return true
    }
}

