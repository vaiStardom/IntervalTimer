//
//  EditTimerViewControllerTextField.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-23.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - TextField and TextView Management
extension EditTimerViewController : UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didUserModifyTimerTopCell()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            if let thePreviousText = textField.text, thePreviousText.count == 1 { //user has emptied the textfield
                isEditing = false
                configureNavBar()
                aesthetics_timerNamePlaceHolder()
                return true
            } else { //user is deleting a character
                didUserModifyTimerTopCell()  
                isEditing = true
                configureNavBar()
                return true
            }
        } else {
            if let thePreviousText = textField.text, thePreviousText.count == 0 {
                isEditing = true
                configureNavBar()
                return true
            } else if string.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                isEditing = true
                configureNavBar()
                return true
            } else {
                didUserModifyTimerTopCell()
                return true
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        timerName = textField.text
        print("------> EditTimerViewController textFieldShouldReturn(textField:) timerName = \(String(describing: timerName))")

        if let theTopCell = topCell() {
            theTopCell.timerNameTextField.resignFirstResponder()
        }
        return true
    }
}

