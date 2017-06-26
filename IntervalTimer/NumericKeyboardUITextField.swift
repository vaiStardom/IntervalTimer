//
//  NumericKeyboardUITextField.swift
//  CustomInputKeyboard
//
//  Created by Paul Addy on 2017-06-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

private var numericKeyboardDelegate: NumericKeyboardDelegate? = nil

class NumericKeyboardUITextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
//MARK: - NumericKeyboardDelegate Methods
extension NumericKeyboardUITextField: NumericKeyboardDelegate {
    internal func numericKeyPressed(key: Int) {
        self.text?.append("\(key)")
        numericKeyboardDelegate?.numericKeyPressed(key: key)
    }
    internal func backspacePressed() {
        if var text = self.text, text.characters.count > 0 {
            _ = text.remove(at: text.index(before: text.endIndex))
            self.text = text
        }
    }
    func setAsNumericKeyboard(delegate: NumericKeyboardDelegate?){
        let numericKeyboard = NumericKeyboardView(frame: CGRect(x: 0, y: 0, width: 0, height: kOCNumericKeyboardRecommendedHeight))
        self.inputView = numericKeyboard
        numericKeyboardDelegate = delegate
        numericKeyboard.delegate = self
    }
    func unsetAsNumericKeyboard(){
        if let numericKeyboard = self.inputView as? NumericKeyboardView {
            numericKeyboard.delegate = nil
        }
        self.inputView = nil
        numericKeyboardDelegate = nil
    }

}
