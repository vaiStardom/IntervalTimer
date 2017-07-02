//
//  IntervalTimerGlobals.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

import Foundation
import UIKit

//MARK: - Fonts


let SYSTEM_BOLD_15: UIFont = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
let SYSTEM_BOLD_17: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
let SYSTEM_HEAVY_35: UIFont = UIFont.systemFont(ofSize: 35, weight: UIFontWeightHeavy)
let SYSTEM_LIGHT_52: UIFont = UIFont.systemFont(ofSize: 52, weight: UIFontWeightLight)
let SYSTEM_REGULAR_13: UIFont = UIFont.systemFont(ofSize: 13, weight: UIFontWeightRegular)
let SYSTEM_REGULAR_15: UIFont = UIFont.systemFont(ofSize: 15, weight: UIFontWeightRegular)
let SYSTEM_REGULAR_17: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
let SYSTEM_REGULAR_19: UIFont = UIFont.systemFont(ofSize: 19, weight: UIFontWeightRegular)
let SYSTEM_REGULAR_28: UIFont = UIFont.systemFont(ofSize: 28, weight: UIFontWeightRegular)
let SYSTEM_SEMIBOLD_17: UIFont = UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold)
let SYSTEM_THIN_60: UIFont = UIFont.systemFont(ofSize: 60, weight: UIFontWeightThin)

let SYSTEM_ULTRALIGHT_61_MONOSPACED: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 61, weight: UIFontWeightUltraLight)
let SYSTEM_ULTRALIGHT_94_MONOSPACED: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 94, weight: UIFontWeightUltraLight)
let SYSTEM_ULTRALIGHT_117_MONOSPACED: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 117, weight: UIFontWeightUltraLight)
let SYSTEM_ULTRALIGHT_65: UIFont = UIFont.systemFont(ofSize: 65, weight: UIFontWeightUltraLight)
let SYSTEM_ULTRALIGHT_117: UIFont = UIFont.systemFont(ofSize: 117, weight: UIFontWeightUltraLight)

let NAVBAR_LEFTRIGHT_FONT = SYSTEM_REGULAR_17
let NAVBAR_TITLE_FONT = SYSTEM_REGULAR_28
let NAVBAR_TITLE_TEMPERATURE_FONT = SYSTEM_REGULAR_17
let CONTENT_LABEL_FONT = SYSTEM_REGULAR_17
let CONTENT_FONT = SYSTEM_REGULAR_28
let EDIT_TIME_FONT = SYSTEM_LIGHT_52
//let TIMER_INTERVAL_TIME_FONT = SYSTEM_THIN_60
let TIMER_INTERVAL_TIME_HOURS_FONT =  SYSTEM_ULTRALIGHT_61_MONOSPACED
let TIMER_INTERVAL_TIME_MINUTES_FONT = SYSTEM_ULTRALIGHT_94_MONOSPACED
let TIMER_INTERVAL_TIME_SECONDS_FONT = SYSTEM_ULTRALIGHT_117_MONOSPACED
let TIMER_NAME_FONT = SYSTEM_HEAVY_35
let TIMER_WEATHERTEMPERATURE_FONT = SYSTEM_REGULAR_17
let TIMERS_NAME_FONT = SYSTEM_THIN_60
let WIDGET_TIMERS_NAME_FONT = SYSTEM_REGULAR_19
let WIDGET_TIME_FONT = SYSTEM_ULTRALIGHT_65
let WIDGET_TEMPERATURE_FONT = SYSTEM_REGULAR_13
let NOTIFICATION_TITLE_FONT = SYSTEM_REGULAR_15
let NOTIFICATION_TIME_FONT = SYSTEM_REGULAR_15
let NOTIFICATION_TIMER_NAME_FONT = SYSTEM_REGULAR_15

//MARK: - Litterals
let NAVBAR_ADDIMAGE = "barButtonAdd"
let NAVBAR_CANCELTITLE = "Cancel"
let NAVBAR_EDITTITLE = "Edit"
let NAVBAR_LEFTTITLE = "Timers"
let NAVBAR_BACKTITLE = "Back"
let NAVBAR_BACKIMAGE = "barButtonBack"
let NAVBAR_NEWTIMERTITLE = "Timer"
let NAVBAR_NEWINTERVALTITLE = "Interval"
let INTERVAL_RED = "redIndicator"
let INTERVAL_GREEN = "greenIndicator"
let INTERVAL_ORANGE = "orangeIndicator"
let INTERVAL_BLUE = "blueIndicator"
let INTERVAL_YELLOW = "yellowIndicator"
let INTERVAL_PURPLE = "purpleIndicator"
let INTERVAL_RED_UNSELECTED = "redIndicatorUnselected"
let INTERVAL_GREEN_UNSELECTED = "greenIndicatorUnselected"
let INTERVAL_ORANGE_UNSELECTED = "orangeIndicatorUnselected"
let INTERVAL_BLUE_UNSELECTED = "blueIndicatorUnselected"
let INTERVAL_YELLOW_UNSELECTED = "yellowIndicatorUnselected"
let INTERVAL_PURPLE_UNSELECTED = "purpleIndicatorUnselected"

//MARK: - CGRects
let DUMMY_CGRECT = CGRect(x: 0, y: 0, width: 65, height: 44)
let NAVBAR_ADDIMAGE_CGRECT = CGRect(x: 20, y: 13, width: 17.5, height: 17.5)
let NAVBAR_BACKIMAGE_CGRECT = CGRect(x: 0, y: 13, width: 12, height: 21)
let NAVBAR_BACKTITLE_LABEL_CGRECT = CGRect(x: 18, y: 14, width: 55, height: 19)
let NAVBAR_BUTTONS_CGRECT = CGRect(x: 0, y: 0, width: 65, height: 44)
let NAVBAR_CANCELBUTTONS_CGRECT = CGRect(x: 0, y: 0, width: 55, height: 44)
let NAVBAR_CANCELLABEL_CGRECT = CGRect(x: 0, y: 14, width: 55, height: 19)
let NAVBAR_EDITLABEL_CGRECT = CGRect(x: 0, y: 14, width: 30, height: 19)
let NAVBAR_LEFTTITLE_LABEL_CGRECT = CGRect(x: 0, y: 14, width: 55, height: 19)
let NAVBAR_NEWTIMERTITLE_CGRECT = CGRect(x: 0, y: 20, width: 86, height: 45)




//let NAVBAR_CANCELBUTTONS_CGRECT = CGRect(x: 0, y: 0, width: 55, height: 44)
//let NAVBAR_CANCELLABEL_CGRECT = CGRect(x: 0, y: 14, width: 55, height: 19)
//let NAVBAR_KAZAUTOLOCKTITLE_CGRECT = CGRect(x: 0, y: 0, width: 204, height: 53)
//let NAVBAR_KEYLABEL_CGRECT = CGRect(x: 20, y: 14, width: 39, height: 19)
//let NAVBAR_KRYPTOKAZTITLE_CGRECT = CGRect(x: 0, y: 0, width: 204, height: 53)
//let NAVBAR_NUMBEROFNOTES_CGRECT = CGRect(x: 0, y: 14, width: 70, height: 19)
//let NAVBAR_SAVEICON_CGRECT = CGRect(x: 0, y: 13, width: 12.68, height: 21.12)
//let NAVBAR_SAVELABEL_CGRECT = CGRect(x: 20, y: 14, width: 39, height: 19)
////let NAVBAR_VAULTTITLE_CGRECT = CGRect(x: 0, y: 0, width: 204, height: 53)
//let NAVBAR_VAULTTITLE_CGRECT = CGRect(x: 0, y: 0, width: 60, height: 53)
