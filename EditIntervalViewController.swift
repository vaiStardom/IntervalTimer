//
//  EditIntervalViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//TODO: User can enter any values he wants in the fields, when he saves, we convert it to the proper hour, min, and seconds values
//TODO: a fade in fade out view telling him about the conversion
//TODO: add alert to user so that they are not allowed to enter any interval higher than 99:59:59
//TODO: Design a delete button
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
    
    let zeroWidthSpace = "\u{200B}" //ZWSP, a non-printing character
    let allowedChars: String = "0123456789"
    
    var indicators:[(imageView: ITVUIImageViewIndicator, activeFillColor: UIColor, inactiveFillColor: UIColor, borderColor: UIColor, indicator: Indicator)] = []
    var selectedIndicator = false
    var indicator: Indicator = Indicator.none
    var isEditingAnInterval: Bool? = false
    var textFields: [UITextField] = []
    var editIntervalProtocolDelegate: ITVEditIntervalProtocol?
    
//    var itvTimerIndex: Int?
//    var itvIntervalIndex: Int?
    var itvUnsavedTimersIntervals: [ITVInterval]?
    var itvIntervalToEdit: ITVInterval?
    
    //[TextField.Tag:TextField.Text]
    var dictTextFieldValues: [Int:String] = [0:"", 1:"", 2:"", 3:"", 4:"", 5:""]
}
