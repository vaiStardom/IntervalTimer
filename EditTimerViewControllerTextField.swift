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
extension EditTimerViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        didUserModifyATimer()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        timerNameTextField.resignFirstResponder()
        return true
    }
}

