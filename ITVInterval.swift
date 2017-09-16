//
//  ITVInterval.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//public struct ITVInterval: Hashable, Equatable {
class ITVInterval: NSObject, NSCoding {
    
    // MARK: - Properties
    fileprivate var seconds: Double?
    fileprivate var indicator: Indicator = Indicator.none
    
    //MARK: - public get/set properties
    public var thisSeconds: Double? {
        get { return seconds}
        set {
            seconds = newValue
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.ITVInterval_seconds)
            UserDefaults.standard.synchronize()
        }
    }
    public var thisIndicator: Indicator {
        get { return indicator}
        set {
            indicator = newValue
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKey.ITVInterval_indicator)
            UserDefaults.standard.synchronize()
        }
    }

    // MARK: - Initializers
    public init(seconds: Double?, indicator: Indicator) {
        super.init()
        guard let theSeconds = seconds, theSeconds > 0 else {
            fatalError("seconds has to be greater than zero")
        }
        thisSeconds = theSeconds
        thisIndicator = indicator
    }
    
    //MARK: - NSCoding protocol methods
    func encode(with coder: NSCoder){
        coder.encode(thisSeconds, forKey: UserDefaultsKey.ITVInterval_seconds)
        
        let theIndicatorRawValue = thisIndicator.rawValue
        coder.encode(theIndicatorRawValue, forKey: UserDefaultsKey.ITVInterval_indicator)
    }
    
    required init(coder decoder: NSCoder) {
        
        if let theSeconds = decoder.decodeObject(forKey: UserDefaultsKey.ITVInterval_seconds) as? Double {
            seconds = theSeconds
        }
        
        let theIndicatorRawValue = decoder.decodeInteger(forKey: UserDefaultsKey.ITVInterval_indicator)
        if let theIndicator = Indicator(rawValue: theIndicatorRawValue) {
            indicator = theIndicator
        }
    }
}
