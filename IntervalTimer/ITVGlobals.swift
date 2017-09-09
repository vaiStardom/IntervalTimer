//
//  ITVGlobals.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

let DEGREE = "\u{00B0}"
let ICON_DICTIONARY: [String: String] = [
    "01d": "clear-sky-day"
    , "01n": "clear-sky-night"
    , "02d": "few-clouds-day"
    , "02n": "few-clouds-night"
    , "03d": "cloudy-day"
    , "03n": "cloudy-night"
    , "04d": "broken-clouds-day"
    , "04n": "broken-clouds-night"
    , "09d": "shower-rain-day"
    , "09n": "shower-rain-night"
    , "10d": "rain-day"
    , "10n": "rain-night"
    , "11d": "thunderstorm-day"
    , "11n": "thunderstorm-night"
    , "13d": "snow-day"
    , "13n": "snow-night"
    , "50d": "mist-day"
    , "50n": "mist-night"
]
//let REVERSE_DNS = "com.example.IntervalTimer"
let NEWCITY_NAME_DISPATCHGROUP = DispatchGroup()
let UTILITY_GLOBAL_DISPATCHQUEUE = DispatchQueue.global(qos: .utility)
