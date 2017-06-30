//
//  EditIntervalViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit


class EditIntervalViewController: UIViewController  {

    @IBOutlet weak var hourTextField2: UITextField!
    @IBOutlet weak var hourTextField1: UITextField!
    @IBOutlet weak var minuteTextField2: UITextField!
    @IBOutlet weak var minuteTextField1: UITextField!
    @IBOutlet weak var secondTextField2: UITextField!
    @IBOutlet weak var secondTextField1: UITextField!
    
    @IBOutlet weak var redIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var greenIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var orangeIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var blueIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var yellowIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var purpleIndicatorImageView: IntervalTimerIndicatorUIImageView!
    
    @IBOutlet weak var redIndicatorButton: UIButton!
    @IBOutlet weak var greenIndicatorButton: UIButton!
    @IBOutlet weak var orangeIndicatorButton: UIButton!
    @IBOutlet weak var blueIndicatorButton: UIButton!
    @IBOutlet weak var yellowIndicatorButton: UIButton!
    @IBOutlet weak var purpleIndicatorButton: UIButton!
    
    let zeroWidthSpace = "\u{200B}" //ZWSP, a non-printing character
    let allowedChars: String = "0123456789"
    
    var indicators:[(imageView: IntervalTimerIndicatorUIImageView, activeImageName: String, inactiveImageName: String)] = []
    var selectedIndicator = false
    
}
//MARK: - Actions
extension EditIntervalViewController {
    @IBAction func redIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 0)
    }
    @IBAction func greenIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 1)
    }
    @IBAction func orangeIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 2)
    }
    @IBAction func blueIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 3)
    }
    @IBAction func yellowIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 4)
    }
    @IBAction func purpleIndicator(_ sender: Any) {
        manageSelectedColorIndicator(indicatorIndex: 5)
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
}


//MARK: - Text Field Management
extension EditIntervalViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //trim out the invisible sign
        let trimmedOutSign = textField.text?.replacingOccurrences(of: zeroWidthSpace, with: "")
        
        //let currentText = textField.text ?? ""
        let currentText = trimmedOutSign

        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) as? UITextField
        
        let previousTag = (textField.tag - 1 == 0 ? 1 : textField.tag - 1)
        var previousResponder = textField.superview?.viewWithTag(previousTag) as? UITextField
        
        
//        let stringEmpty = ""
//        print("------>trimmedOutSign = \(trimmedOutSign ?? stringEmpty)")
//        print("------>currentText = \(currentText ?? stringEmpty)")
//        print("------>prospectiveText = \(string)")
//        print("------>textField.tag = \(textField.tag)")
//        print("------>nextTag = \(nextTag)")
//        print("------>previousTag = \(previousTag)")
        
        
        if ((currentText?.characters.count)! < 1
            && string.characters.count > 0
            && string.containsOnlyCharactersIn(matchCharacter: allowedChars)){ // User inputs 1 number
        
//            print("------>First condition = User inputs 1 number")
            
            textField.text = string
            nextResponder?.becomeFirstResponder()
            
            return false
            
        } else if ((currentText?.characters.count)! >= 1
            && string.characters.count == 0){ // User deletes the contents
            
//            print("------>Second condition = User deletes the contents, previous textField becomeFirstResponder()")
            
            if (previousResponder == nil){ //if we cant find the revious textField, set it to the first text field
                previousResponder = textField.superview?.viewWithTag(0) as? UITextField
            }

            textField.text = zeroWidthSpace
            previousResponder?.becomeFirstResponder()
            return false

        } else if ((currentText?.characters.count)! == 0
            && string.characters.count == 0){ // TextField is empty, user backspaces.
            
//            print("------>Third condition = TextField is empty, user backspaces.")
            
            textField.text = zeroWidthSpace
            
            if let previousTextField = previousResponder {
//                print("------>Third condition = Delete contents of previous uitextfield.")
                previousTextField.text = zeroWidthSpace
            }
            previousResponder!.becomeFirstResponder()
            
            return false
        } else {
//            print("------>FOURTH CONDITION = ?")
            textField.text = zeroWidthSpace
            return false
        }
    }

//        let currentText = textField.text ?? ""
//        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
//
//        
//        if (currentText.characters.count < 1
//            && string.characters.count > 0
//            && prospectiveText.containsOnlyCharactersIn(matchCharacter: allowedChars)){ // User inputs 1 number
//            
//            textField.text = prospectiveText
//            
//            let nextTag = textField.tag + 1
//            let nextResponder = textField.superview?.viewWithTag(nextTag)
//
//            if (nextResponder == nil){
//                textField.resignFirstResponder()
//            }
//            nextResponder?.becomeFirstResponder()
//            
//            return false
//            
//        } else if (currentText.characters.count >= 1
//            && prospectiveText.characters.count == 0){ // User deletes the contents
//
//            let previousTag = textField.tag - 1
//            var previousResponder = textField.superview?.viewWithTag(previousTag)
//            
//            if (previousResponder == nil){ //if we cant find the revious textField, set it to the first text field
//                previousResponder = textField.superview?.viewWithTag(0)
//            }
//            
//            //textField.text = InvisibleSign
//            textField.text = ""
//            previousResponder?.becomeFirstResponder()
//            return false
//        } else {
//            //textField.text = InvisibleSign
//            
//            //todo invetigate why it comes here?
//            textField.text = ""
//            return false
//        }
}
//MARK: - Helpers
extension EditIntervalViewController {
    func manageSelectedColorIndicator(indicatorIndex: Int){
        indicators[indicatorIndex].imageView.isSelected = !indicators[indicatorIndex].imageView.isSelected
        selectedIndicator = indicators[indicatorIndex].imageView.isSelected
        unselectAllIndicators()
        indicators[indicatorIndex].imageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            indicators[indicatorIndex].imageView.image = UIImage(named: indicators[indicatorIndex].activeImageName)
        }
    }
    func unselectAllIndicators(){
        for indicator in indicators {
            indicator.imageView.isSelected = false
            indicator.imageView.image = UIImage(named: indicator.inactiveImageName)
        }
    }
}
//MARK: Life-cycle
extension EditIntervalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        secondTextField1.becomeFirstResponder()

        hourTextField2.delegate = self
        hourTextField1.delegate = self
        minuteTextField2.delegate = self
        minuteTextField1.delegate = self
        secondTextField2.delegate = self
        secondTextField1.delegate = self
        
        hourTextField2.text = zeroWidthSpace
        hourTextField1.text = zeroWidthSpace
        minuteTextField2.text = zeroWidthSpace
        minuteTextField1.text = zeroWidthSpace
        secondTextField2.text = zeroWidthSpace
        secondTextField1.text = zeroWidthSpace
        
        indicators.append((imageView: redIndicatorImageView, activeImageName: INTERVAL_RED, inactiveImageName: INTERVAL_RED_UNSELECTED))
        indicators.append((imageView: greenIndicatorImageView, activeImageName: INTERVAL_GREEN, inactiveImageName: INTERVAL_GREEN_UNSELECTED))
        indicators.append((imageView: orangeIndicatorImageView, activeImageName: INTERVAL_ORANGE, inactiveImageName: INTERVAL_ORANGE_UNSELECTED))
        indicators.append((imageView: blueIndicatorImageView, activeImageName: INTERVAL_BLUE, inactiveImageName: INTERVAL_BLUE_UNSELECTED))
        indicators.append((imageView: yellowIndicatorImageView, activeImageName: INTERVAL_YELLOW, inactiveImageName: INTERVAL_YELLOW_UNSELECTED))
        indicators.append((imageView: purpleIndicatorImageView, activeImageName: INTERVAL_PURPLE, inactiveImageName: INTERVAL_PURPLE_UNSELECTED))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: - Navigation Bar Management
extension EditIntervalViewController {
    func configureNavBar(){
        self.navigationItem.hidesBackButton = true
        
        let backButton = IntervalTimerUIBarButtonItem().backButton(target: self, selector: #selector(EditIntervalViewController.back))
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let label = IntervalTimerUILabel().navBarNewIntervalTitle()
        self.navigationItem.titleView = label
        
        let negativeSpace = IntervalTimerUIBarButtonItem().negativeSpace()
        let cancelButton = IntervalTimerUIBarButtonItem().cancelButton(target: self, selector: #selector(EditIntervalViewController.cancel))
        self.navigationItem.rightBarButtonItems = [negativeSpace, cancelButton]
    }
}
private extension String{
    func containsOnlyCharactersIn(matchCharacter: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacter).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
}
