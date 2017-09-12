//
//  ITVHashableIdGenerator.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-11.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class ITVHashableIdGenerator {
    private var nextId = 0
    func generate() -> Int {
        nextId += 1
        return nextId
    }
}
