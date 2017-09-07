//
//  IntervalTimerCity.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-31.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

public struct ITVCity {
    
    // MARK: - Properties
    private var name: String?
    
    //MARK: - Typealias
    typealias ITVNewCityErrorHandler = ((Error?) -> Void)

    //MARK: - public get/set properties
    public var thisName: String? {
        get { return name }
        set { name = newValue }
    }
    
    // MARK: - Initializers
    public init(name: String) {
        self.name = name
    }
    
    public init(json: [String: Any]) throws {
        guard let theAddress = json["address"] as? [String: String] else {
            throw ITVError.JSON_Missing("json key address")
        }
        guard let theCity = theAddress["city"] else {
            throw ITVError.JSON_Missing("json key city")
        }
        self.name = theCity
    }
}
