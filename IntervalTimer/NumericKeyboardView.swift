//
//  NumericKeyboardView.swift
//  CustomInputKeyboard
//
//  Created by Paul Addy on 2017-06-26.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

@objc protocol NumericKeyboardDelegate {
    func numericKeyPressed(key: Int)
    func backspacePressed()
}

let kOCNumericKeyboardRecommendedHeight = 240.0

class NumericKeyboardView: UIView {

    //MARK: - Properties
    @IBOutlet weak var key1Button: UIButton!
    @IBOutlet weak var key2Button: UIButton!
    @IBOutlet weak var key3Button: UIButton!
    @IBOutlet weak var key4Button: UIButton!
    @IBOutlet weak var key5Button: UIButton!
    @IBOutlet weak var key6Button: UIButton!
    @IBOutlet weak var key7Button: UIButton!
    @IBOutlet weak var key8Button: UIButton!
    @IBOutlet weak var key9Button: UIButton!
    @IBOutlet weak var key0Button: UIButton!
    
    @IBOutlet weak var backspaceButton: UIButton!
    
    // data
    weak var delegate: NumericKeyboardDelegate?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeKeyboard()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeKeyboard()
    }
}
//MARK: - Actions
extension NumericKeyboardView{
    @IBAction func numberPressed(_ sender: UIButton) {
        self.delegate?.numericKeyPressed(key: sender.tag)
        
        sender.alpha = 0.80
        UIView.animate(withDuration: 1.5, animations: {
            sender.alpha = 1
        })
        
    }
    @IBAction func backspacePressed(_ sender: UIButton) {
        self.delegate?.backspacePressed()
    }
}
//MARK: - Helpers
extension NumericKeyboardView{
    func initializeKeyboard(){
        let xibFileName = "NumericKeyboardView"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
}
