//
//  IntervalTimer_HTTP_Tests.swift
//  IntervalTimer_HTTP_Tests
//
//  Created by Paul Addy on 2017-10-24.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import XCTest
@testable import IntervalTimer

//TODO: TEST the performance of getting the weather on the network (and later, make this test for every device type with each their oen baseline)
// These tests validate access to the OpenWeatherApi and MapQuestApi
class IntervalTimer_HTTP_Tests: XCTestCase {

    var session: URLSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = URLSession.shared
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        super.tearDown()
    }

    func testHTTP200_GetWeatherWith_Coordinates(){
        // GIVEN
        let latitude: Double = -8.549790
        let longitude: Double = 116.072037
        
        let url = URL(string: "\(OpenWeatherApi.baseUrl)lat=\(latitude)&lon=\(longitude)&APPID=\(OpenWeatherApi.key)")
        let promise = expectation(description: "Status code: 200")
        
        var statusCode: Int?
        var responseError: Error?
        
        // WHEN
        let dataTask = session.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // THEN
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testHTTP200_GetWeatherWith_LocationName(){
        // GIVEN
        let cityName = "Mataram"
        let countryCode = "id"
        let url = URL(string: "\(OpenWeatherApi.baseUrl)q=\(cityName),\(countryCode.lowercased())&APPID=\(OpenWeatherApi.key)")
        let promise = expectation(description: "Status code: 200")
        
        var statusCode: Int?
        var responseError: Error?
        
        // WHEN
        let dataTask = session.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // THEN
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testHTTP200_GetWeatherWith_CityId(){
        // GIVEN
        let cityId = 1635882
        let url = URL(string: "\(OpenWeatherApi.baseUrl)id=\(cityId)&APPID=\(OpenWeatherApi.key)")
        let promise = expectation(description: "Status code: 200")
        
        var statusCode: Int?
        var responseError: Error?
        
        // WHEN
        let dataTask = session.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // THEN
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

    func testHTTP200_GetCityName(){

        // GIVEN
        let latitude: Double = 45.514589
        let longitude: Double = -73.559794
        let url = URL(string: "\(MapQuestApi.baseUrl)key=\(MapQuestApi.key)&format=json&lat=\(latitude)&lon=\(longitude)&accept-language=en")
        let promise = expectation(description: "Status code: 200")
        
        var statusCode: Int?
        var responseError: Error?
        
        // WHEN
        let dataTask = session.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // THEN
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
