//
//  IntervalTimerTests.swift
//  IntervalTimerTests
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import XCTest
@testable import IntervalTimer

//TODO: - TEST ITVDownloadJSON.downloadJSON(completion:) with the many wifi simulated connexion options in ios11 dev options
//TODO: + TEST for a new timer, the segmented control does not always appear when switching show temperature to on for the first time.
//TODO: + TEST the pasting on non-numerioc characters in the interval text fields
//TODO: - TEST the retreival of weather for each priority, and then for each priority escalation from low to high
//TODO: - Validate each weather retreival priority, by test cases:
//case 1: a locality where there is no city id, but a city name and country code weather may be retreived
//case 2: a locality where neither the city id, or locality name weather does not work, only coodinates
//TODO: - TEST Handle case where network connexions are disabled (same way as the disabled locations services)
//TODO: - TEST the cancelling of getting the weather
//TODO: - TEST if weather switch is switched OFF and weather has not finished loading, then cancel weather loading (cancel network calls)
//TODO: - TEST if the weather is not updated after 5 seconds, than put the warning icon to warn user that the network is not working, do the same thing if insufficient data exists to determine a location
//TODO: + TEST that we never get 0 seconds when there are intervals in the timer
//TODO: + TEST that the timers loading animations animates only when app launches, and that it does not occur at every view appear
//TODO: - TEST the possibility that reading the csv always succeeds
//TODO: - TEST CSV that the fields.coun is always equal to the columnTitles.count City line mal formated, skip this line and continue searching, and find a way to log this error or report it back if this happens in the field
//TODO: - TEST CSV that there is always data in the file
//TODO: + TEST that an interval is never created or saved with zero seconds
//TODO: + TEST Show warning that airplane mode is on by simply putting that icon where the weather is (no alert)
//TODO: + TEST Show milliseconds when down to minutes and seconds.
//TODO: + TEST currentReachabilityStatus
//guard currentReachabilityStatus != .notReachable else {
//    completion(nil, ITVError.Reachability_notReachable(reason: "Network is unreachable."))
//    return
//}

class IntervalTimerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
