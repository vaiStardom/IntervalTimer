//
//  IntervalTimer_JSON_Tests.swift
//  IntervalTimer_JSON_Tests
//
//  Created by Paul Addy on 2017-10-24.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import XCTest
import SystemConfiguration

@testable import IntervalTimer

class IntervalTimer_JSON_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParseWeather() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "weather", ofType: "json")
        if let data = NSData(contentsOfFile: path!){
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
                
                guard JSONSerialization.isValidJSONObject(jsonDictionary) else {
                    XCTFail("\(ITVError.JSON_Download("JSONSerialization.isValidJSONObject(jsonDictionary) = false"))")
                    return
                }
                let results = try ITVCurrentWeather(json: (jsonDictionary as? [String:Any])!)
                XCTAssertNotNil(results)
            } catch let error {
                XCTFail("\(error)")
            }
        }
    }

    func testParseCityName() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "cityName", ofType: "json")
        if let data = NSData(contentsOfFile: path!){
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
                
                guard JSONSerialization.isValidJSONObject(jsonDictionary) else {
                    XCTFail("\(ITVError.JSON_Download("JSONSerialization.isValidJSONObject(jsonDictionary) = false"))")
                    return
                }
                let results = try ITVCity(json: (jsonDictionary as? [String:Any])!)
                XCTAssertNotNil(results)
            } catch let error {
                XCTFail("\(error)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
