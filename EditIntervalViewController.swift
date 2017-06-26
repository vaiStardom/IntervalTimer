//
//  EditIntervalViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class EditIntervalViewController: UIViewController, NumericKeyboardDelegate  {
    
    @IBOutlet weak var hourTextField2: NumericKeyboardUITextField!
    @IBOutlet weak var hourTextField1: NumericKeyboardUITextField!
    @IBOutlet weak var minuteTextField2: NumericKeyboardUITextField!
    @IBOutlet weak var minuteTextField1: NumericKeyboardUITextField!
    @IBOutlet weak var secondTextField2: NumericKeyboardUITextField!
    @IBOutlet weak var secondTextField1: NumericKeyboardUITextField!
    
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
    
    var intervalTimerIndicatorUIImageViews = [IntervalTimerIndicatorUIImageView]()
    var selectedIndicator = false
}
//MARK: - Actions
extension EditIntervalViewController {
    @IBAction func redIndicator(_ sender: Any) {
        redIndicatorImageView.isSelected = !redIndicatorImageView.isSelected
        selectedIndicator = redIndicatorImageView.isSelected
        unselectAllIndicators()
        redIndicatorImageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            redIndicatorImageView.image = UIImage(named: INTERVAL_RED)
        }
    }
    @IBAction func greenIndicator(_ sender: Any) {
        greenIndicatorImageView.isSelected = !greenIndicatorImageView.isSelected
        selectedIndicator = greenIndicatorImageView.isSelected
        unselectAllIndicators()
        greenIndicatorImageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            greenIndicatorImageView.image = UIImage(named: INTERVAL_GREEN)
        }
    }
    @IBAction func orangeIndicator(_ sender: Any) {
        orangeIndicatorImageView.isSelected = !orangeIndicatorImageView.isSelected
        selectedIndicator = orangeIndicatorImageView.isSelected
        unselectAllIndicators()
        orangeIndicatorImageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            orangeIndicatorImageView.image = UIImage(named: INTERVAL_ORANGE)
        }
    }
    @IBAction func blueIndicator(_ sender: Any) {
        blueIndicatorImageView.isSelected = !blueIndicatorImageView.isSelected
        selectedIndicator = blueIndicatorImageView.isSelected
        unselectAllIndicators()
        blueIndicatorImageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            blueIndicatorImageView.image = UIImage(named: INTERVAL_BLUE)
        }
    }
    @IBAction func yellowIndicator(_ sender: Any) {
        yellowIndicatorImageView.isSelected = !yellowIndicatorImageView.isSelected
        selectedIndicator = yellowIndicatorImageView.isSelected
        unselectAllIndicators()
        yellowIndicatorImageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            yellowIndicatorImageView.image = UIImage(named: INTERVAL_YELLOW)
        }
    }
    @IBAction func purpleIndicator(_ sender: Any) {
        purpleIndicatorImageView.isSelected = !purpleIndicatorImageView.isSelected
        selectedIndicator = purpleIndicatorImageView.isSelected
        unselectAllIndicators()
        purpleIndicatorImageView.isSelected = selectedIndicator
        if selectedIndicator == true {
            purpleIndicatorImageView.image = UIImage(named: INTERVAL_PURPLE)
        }
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func cancel(){
        _ = navigationController?.popViewController(animated: true)
    }
}
////MARK: - Text Field Management
//extension EditIntervalViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        <#code#>
//    }
//}
//MARK: - Helpers
extension EditIntervalViewController {
    func unselectAllIndicators(){
        for indicatorImageView in intervalTimerIndicatorUIImageViews{
            indicatorImageView.isSelected = false
        }

        redIndicatorImageView.image = UIImage(named: INTERVAL_RED_UNSELECTED)
        greenIndicatorImageView.image = UIImage(named: INTERVAL_GREEN_UNSELECTED)
        orangeIndicatorImageView.image = UIImage(named: INTERVAL_ORANGE_UNSELECTED)
        blueIndicatorImageView.image = UIImage(named: INTERVAL_BLUE_UNSELECTED)
        yellowIndicatorImageView.image = UIImage(named: INTERVAL_YELLOW_UNSELECTED)
        purpleIndicatorImageView.image = UIImage(named: INTERVAL_PURPLE_UNSELECTED)
    }
}
//MARK: Life-cycle
extension EditIntervalViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        //secondTextField2.becomeFirstResponder()

        intervalTimerIndicatorUIImageViews.append(redIndicatorImageView)
        intervalTimerIndicatorUIImageViews.append(greenIndicatorImageView)
        intervalTimerIndicatorUIImageViews.append(orangeIndicatorImageView)
        intervalTimerIndicatorUIImageViews.append(blueIndicatorImageView)
        intervalTimerIndicatorUIImageViews.append(yellowIndicatorImageView)
        intervalTimerIndicatorUIImageViews.append(purpleIndicatorImageView)
        
        hourTextField2.setAsNumericKeyboard(delegate: self)
        hourTextField1.setAsNumericKeyboard(delegate: self)
        minuteTextField2.setAsNumericKeyboard(delegate: self)
        minuteTextField1.setAsNumericKeyboard(delegate: self)
        secondTextField2.setAsNumericKeyboard(delegate: self)
        secondTextField1.setAsNumericKeyboard(delegate: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: - NumericKeyboardDelegate Management
extension EditIntervalViewController{
    func numericKeyPressed(key: Int) {
        print("Numeric key \(key) pressed")
    }
    func backspacePressed() {
        print("Backspace pressed")
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
