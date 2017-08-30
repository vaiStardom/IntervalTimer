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
    
    @IBOutlet weak var firstIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var secondIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var thirdIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var fourthIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var fifthIndicatorImageView: IntervalTimerIndicatorUIImageView!
    @IBOutlet weak var sixthIndicatorImageView: IntervalTimerIndicatorUIImageView!
    
    @IBOutlet weak var firstIndicatorButton: UIButton!
    @IBOutlet weak var secondIndicatorButton: UIButton!
    @IBOutlet weak var thirdIndicatorButton: UIButton!
    @IBOutlet weak var fourthndicatorButton: UIButton!
    @IBOutlet weak var fifthIndicatorButton: UIButton!
    @IBOutlet weak var sixthIndicatorButton: UIButton!
    
    let zeroWidthSpace = "\u{200B}" //ZWSP, a non-printing character
    let allowedChars: String = "0123456789"
    
    var indicators:[(imageView: IntervalTimerIndicatorUIImageView, activeFillColor: UIColor, inactiveFillColor: UIColor, borderColor: UIColor)] = []
    var selectedIndicator = false
}
