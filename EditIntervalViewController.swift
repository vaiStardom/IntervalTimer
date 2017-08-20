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
        
        indicators.append((imageView: redIndicatorImageView, activeImageName: IntervalImage.Red, inactiveImageName: IntervalImage.RedUnselected))
        indicators.append((imageView: greenIndicatorImageView, activeImageName: IntervalImage.Green, inactiveImageName: IntervalImage.GreenUnselected))
        indicators.append((imageView: orangeIndicatorImageView, activeImageName: IntervalImage.Orange, inactiveImageName: IntervalImage.OrangeUnselected))
        indicators.append((imageView: blueIndicatorImageView, activeImageName: IntervalImage.Blue, inactiveImageName: IntervalImage.BlueUnselected))
        indicators.append((imageView: yellowIndicatorImageView, activeImageName: IntervalImage.Yellow, inactiveImageName: IntervalImage.YellowUnselected))
        indicators.append((imageView: purpleIndicatorImageView, activeImageName: IntervalImage.Purple, inactiveImageName: IntervalImage.PurpleUnselected))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
