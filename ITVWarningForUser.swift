//
//  ITVWarningForUser.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-07.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class ITVWarningForUser {
    
    //MARK: - Singleton
    static let sharedInstance = ITVWarningForUser()
    
    //MARK: - Fileprivate properties
    fileprivate var userWarning: UserWarning?
    fileprivate var message: String?
    
    //MARK: - public get/set properties
    var thisUserWarning: UserWarning? {
        get { return userWarning }
        set {
            userWarning = newValue
        }
    }
    var thisMessage: String? {
        get { return message }
        set {
            message = newValue
        }
    }
}
