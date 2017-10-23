//
//  EditIntervalViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//TODO: UI -> add alert to user so that they are not allowed to enter any interval higher than 99:59:59 and then take watever they entered and replace it with 99:59:59
class EditIntervalViewController: UIViewController  {

    @IBOutlet weak var hourTextField2: UITextField!
    @IBOutlet weak var hourTextField1: UITextField!
    @IBOutlet weak var minuteTextField2: UITextField!
    @IBOutlet weak var minuteTextField1: UITextField!
    @IBOutlet weak var secondTextField2: UITextField!
    @IBOutlet weak var secondTextField1: UITextField!
    
    @IBOutlet weak var firstIndicatorImageView: ITVUIImageViewIndicator!
    @IBOutlet weak var secondIndicatorImageView: ITVUIImageViewIndicator!
    @IBOutlet weak var thirdIndicatorImageView: ITVUIImageViewIndicator!
    @IBOutlet weak var fourthIndicatorImageView: ITVUIImageViewIndicator!
    @IBOutlet weak var fifthIndicatorImageView: ITVUIImageViewIndicator!
    @IBOutlet weak var sixthIndicatorImageView: ITVUIImageViewIndicator!
    
    @IBOutlet weak var firstIndicatorButton: UIButton!
    @IBOutlet weak var secondIndicatorButton: UIButton!
    @IBOutlet weak var thirdIndicatorButton: UIButton!
    @IBOutlet weak var fourthndicatorButton: UIButton!
    @IBOutlet weak var fifthIndicatorButton: UIButton!
    @IBOutlet weak var sixthIndicatorButton: UIButton!
    
    let zeroWidthSpace = Litterals.ZeroWidthSpace
//    let allowedChars: String = "0123456789"
    let allowedChars = Litterals.IntervalAllowedCharacters
    
    var indicators:[(imageView: ITVUIImageViewIndicator, activeFillColor: UIColor, inactiveFillColor: UIColor, borderColor: UIColor, indicator: Indicator)] = []
    var selectedIndicator = false
    var indicator: Indicator = Indicator.none
    var isEditingAnInterval: Bool? = false
    var textFields: [UITextField] = []
    var editIntervalProtocolDelegate: ITVEditIntervalProtocol?
    
    var itvUnsavedTimersIntervals: [ITVInterval]?
    var itvIntervalToEdit: ITVInterval?
    
    var dictTextFieldValues: [Int:String] = [0:"", 1:"", 2:"", 3:"", 4:"", 5:""]
}
